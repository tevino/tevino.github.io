require 'nokogiri'

Jekyll::Hooks.register :site, :post_write do |site|
  puts "Checking for unrendered markdown..."
  
  unrendered_patterns = [
    { name: "Unlinked brackets (e.g., [text])", pattern: /\[(?!\s*(?:a|img|iframe))[^\]]+\](?!\()/ },
    { name: "Unclosed bold (e.g., **text)", pattern: /\*\*(?![^\s*]+\*\*)/ },
    { name: "Single backticks (e.g., `code`)", pattern: /`[^`\n]+`(?!`)/ },
    { name: "Unrendered list item (e.g., - item)", pattern: /^\s*[-+*]\s(?![^\n]*<\/li>)/ },
    { name: "Unrendered footnote (e.g., [^note])", pattern: /\[\^[a-zA-Z0-9\-_]+\]/ },
    { name: "Unrendered link (e.g., [link])", pattern: /\[[a-zA-Z0-9\-_]+\]/ }
  ]

  # Add a list of files to ignore
  ignored_files = []

  # Add a flag to track if any issues were found
  issues_found = false

  def check_content(item, ignored_files, unrendered_patterns, issues_found)
    return issues_found unless item.output_ext == '.html'  # Only check HTML files
    return issues_found if ignored_files.include?(File.basename(item.path))  # Skip ignored files
    
    # Parse the HTML content
    doc = Nokogiri::HTML(item.output)

    # Remove script, style, pre, and code tags
    doc.css('script, style, pre, code').remove

    # Extract only the body content
    body_content = doc.at('body')&.inner_html
    return issues_found unless body_content

    unrendered_patterns.each do |rule|
      matches = body_content.to_enum(:scan, rule[:pattern]).map { Regexp.last_match }
      next unless matches.any?

      puts "Warning: Possible unrendered markdown in #{item.path}"
      puts "  Rule: #{rule[:name]}"
      matches.each do |match|
        context = extract_context(body_content, match)
        puts "  Context: ...#{context}..."
      end
      puts "\n"

      # Set the flag to true if any issues are found
      issues_found = true
    end

    issues_found
  end

  def extract_context(content, match, context_length = 30)
    start_index = [match.begin(0) - context_length, 0].max
    end_index = [match.end(0) + context_length, content.length - 1].min
    content[start_index..end_index].gsub(/\s+/, ' ').strip
  end

  # Check pages
  site.pages.each { |page| issues_found = check_content(page, ignored_files, unrendered_patterns, issues_found) }

  # Check posts
  site.posts.docs.each { |post| issues_found = check_content(post, ignored_files, unrendered_patterns, issues_found) }

  # Fail the build if any issues were found
  if issues_found
    puts "Error: Unrendered markdown detected."
    exit(1)
  else
    puts "No unrendered markdown detected."
  end
end