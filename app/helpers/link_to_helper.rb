# frozen_string_literal: true

module LinkToHelper
  ##
  # "Index" button using `link_to`
  #
  # Example
  #   link_to_index('Index', '/foo') =>
  #   link_to_index('Index', '/foo', class: 'btn btn-foo')
  #
  def link_to_index(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-secondary btn-action btn-index',
      icon: 'bi bi-collection'
    )

    link_to_custom(name, link, options)
  end

  ##
  # "Show" button using `link_to`
  #
  # Example
  #   link_to_new('Show', '/foo')
  #   link_to_new('Show', '/foo', class: 'btn btn-foo')
  #
  def link_to_show(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-primary btn-action btn-show',
      icon: 'bi bi-eye'
    )

    link_to_custom(name, link, options)
  end

  ##
  # "New" button using `link_to`
  #
  # Example
  #   link_to_new('New', '/foo')
  #   link_to_new('New', '/foo', class: 'btn btn-foo')
  #
  def link_to_new(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-success btn-action btn-new',
      icon: 'bi bi-file-earmark-plus'
    )

    link_to_custom(name, link, options)
  end

  ##
  # "Edit" button using `link_to`
  #
  # Example
  #   link_to_edit('Edit', '/foo')
  #   link_to_edit('Edit', '/foo', class: 'btn btn-foo')
  #
  def link_to_edit(name = nil, link = nil, options = {})
    options = options.reverse_merge(
      class: 'btn btn-info btn-action btn-edit',
      icon: 'bi bi-pencil'
    )

    link_to_custom(name, link, options)
  end

  ##
  # "Delete" button using `link_to`
  #
  # Example
  #   link_to_delete('Delete', '/foo')
  #   link_to_delete('Delete', '/foo', class: 'btn btn-foo')
  #   link_to_delete('Delete', '/foo', class: 'btn btn-foo', data: { confirm: 'Really delete?' })
  #
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

  ##
  # "Restore" button using `link_to`
  #
  # Example
  #   link_to_restore('Restore', '/foo')
  #   link_to_restore('Restore', '/foo', class: 'btn btn-foo')
  #
  def link_to_restore(name = nil, link = nil, options = {})
    options = {
      class: 'btn btn-danger btn-action btn-restore',
      icon: 'bi bi-arrow-repeat',
      method: :post
    }.deep_merge(options)

    link_to_custom(name, link, options)
  end

  ##
  # Custom button using `link_to`
  #
  # Example
  #   link_to_custom('Foo', '/foo')
  #   link_to_custom('Foo', '/foo', class: 'btn btn-foo')
  #
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

  ##
  # Generic icon helper
  #
  # Example
  #   _link_to_icon => nil
  #   _link_to_icon('bi bi-exclamation') => <i class="bi bi-exclamation"></i>
  #   _link_to_icon('foo') => <i class="foo"></i>
  #
  def _link_to_icon(klass = nil)
    return if klass.blank?

    tag.i class: klass
  end

  ##
  # Generic text helper
  #
  # Example
  #   _link_to_text => nil
  #   _link_to_text('hello') => <span>hello</span>
  #
  def _link_to_text(text = nil)
    return if text.blank?

    tag.span(text)
  end
end
