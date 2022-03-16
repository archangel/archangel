# frozen_string_literal: true

# Custom link_to helpers
module LinkToHelper
  # "Index" button using `link_to`
  #
  # @example With default options
  #   link_to_index('Index', '/foo') #=> '<a href="/foo">Index</a>'
  #
  # @example With class option
  #   link_to_index('Index', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Index</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_index(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-secondary btn-action btn-index',
      icon: 'bi bi-collection'
    )

    link_to_custom(name, link, options)
  end

  # "Show" button using `link_to`
  #
  # @example With default options
  #   link_to_show('Show', '/foo') #=> '<a href="/foo">Show</a>'
  #
  # @example With class option
  #   link_to_show('Show', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Show</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_show(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-primary btn-action btn-show',
      icon: 'bi bi-eye'
    )

    link_to_custom(name, link, options)
  end

  # "New" button using `link_to`
  #
  # @example With default options
  #   link_to_new('New', '/foo') #=> '<a href="/foo">New</a>'
  #
  # @example With class option
  #   link_to_new('New', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">New</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_new(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-success btn-action btn-new',
      icon: 'bi bi-file-earmark-plus'
    )

    link_to_custom(name, link, options)
  end

  # "Edit" button using `link_to`
  #
  # @example With default options
  #   link_to_edit('Edit', '/foo') #=> '<a href="/foo">Edit</a>'
  #
  # @example With class option
  #   link_to_edit('Edit', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Edit</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_edit(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-info btn-action btn-edit',
      icon: 'bi bi-pencil'
    )

    link_to_custom(name, link, options)
  end

  # "Delete" button using `link_to`
  #
  # @example With default options
  #   link_to_delete('Delete', '/foo') #=> '<a href="/foo">Delete</a>'
  #
  # @example With class option
  #   link_to_delete('Delete', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Delete</a>'
  #
  # @example With custom confirm delete data
  #   link_to_delete('Delete', '/foo', data: { confirm: 'Really delete?' })#=> '<a href="/foo" data-confirm="Really delete?">Delete</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_delete(name = nil, link = nil, options = {})
    options = {
      class: 'btn btn-danger btn-action btn-delete',
      icon: 'bi bi-trash',
      data: { confirm: I18n.t('are_you_sure') },
      method: :delete
    }.deep_merge(options)

    link_to_custom(name, link, options)
  end
  alias link_to_destroy link_to_delete

  # "Restore" button using `link_to`
  #
  # @example With default options
  #   link_to_restore('Restore', '/foo') #=> '<a href="/foo">Restore</a>'
  #
  # @example With class option
  #   link_to_restore('Restore', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Restore</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_restore(name = nil, link = nil, options = {})
    options = {
      class: 'btn btn-warning btn-action btn-restore',
      icon: 'bi bi-arrow-repeat',
      method: :post
    }.deep_merge(options)

    link_to_custom(name, link, options)
  end

  # Custom button using `link_to`
  #
  # @example With default options
  #   link_to_custom('Foo', '/foo') #=> '<a href="/foo">Foo</a>'
  #
  # @example With class option
  #   link_to_custom('Foo', '/foo', class: 'btn btn-foo')#=> '<a href="/foo" class="btn btn-foo">Foo</a>'
  #
  # @param [String] name the link text
  # @param [String] link the link
  # @param [Hash] options the options
  # @option options [String] :class link class
  # @option options [String] :icon icon class
  # @return [String] HTML link
  def link_to_custom(name = nil, link = nil, options = {})
    options = { class: 'btn btn-secondary btn-action',
                icon: 'bi bi-exclamation',
                role: 'button',
                data: { 'bs-toggle' => 'tooltip' },
                title: name }.deep_merge(options)

    display_text = [
      _link_to_icon(options.delete(:icon)), _link_to_text(name)
    ].compact.join(' ')
    display_name = sanitize(display_text)

    link_to(display_name, link, options)
  end

  private

  # Generic icon helper
  #
  # @example With no HTML class
  #   _link_to_icon #=> nil
  #
  # @example With single class
  #   _link_to_icon('foo') #=> '<i class="foo"></i>'
  #
  # @example With multiple classes
  #   _link_to_icon('bi bi-exclamation') #=> '<i class="bi bi-exclamation"></i>'
  #
  # @param [String] klass HTML class
  # @return [String] italic HTML tag
  def _link_to_icon(klass = nil)
    return if klass.blank?

    tag.i class: klass
  end

  # Generic text helper
  #
  # @example With no text in span tag
  #   _link_to_text #=> nil
  #
  # @example With text in span tag
  #   _link_to_text('hello') #=> '<span>hello</span>'
  #
  # @param [String] text text inside span
  # @return [String] italic HTML tag
  def _link_to_text(text = nil)
    return if text.blank?

    tag.span(text)
  end
end
