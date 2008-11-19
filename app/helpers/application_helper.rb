# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def proper_form_for(record_or_name_or_array, *args, &proc) 
    options = args.detect { |argument| argument.is_a?(Hash) } 
    if options.nil? 
      options = {:builder => ProperFormBuilder} 
      args << options 
    end 
    options[:builder] = ProperFormBuilder unless options.nil? 
    form_for(record_or_name_or_array, *args, &proc) 
  end 

  def fieldset(options={}, &proc)
    # add fieldset header to current template IO stream
    start  = "<fieldset" << ( options[:class] ? " class=\""+options[:class]+"\"" : "") << ">"
    finish = "</fieldset>"
    start << "<legend>#{options[:legend]}</legend>" if options[:legend]
    unless options[:class] =~ /submit|buttons/
      start << "<ol>"
      finish.insert(0, "</ol>")
    end
    concat(start, proc.binding)
    # Generate content
    yield 
    # add panel footer to current template IO stream
    concat(finish, proc.binding)
  end

  
  def current_user_promotion
    current_user && current_user.promotion
  end
end
