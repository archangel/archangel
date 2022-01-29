# frozen_string_literal: true

RSpec.describe LinkToHelper, type: :helper do
  context 'with #link_to_delete' do
    it 'returns default button' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a.btn.btn-danger.btn-action', text: 'Delete')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[role="button"]', text: 'Delete')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[title="Delete"]', text: 'Delete')
    end

    it 'has correct `data-method` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[data-method="delete"]', text: 'Delete')
    end

    it 'has correct `data-confirm` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[data-confirm="Are you sure?"]', text: 'Delete')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'Delete')
    end

    it 'has correct `rel` value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a[rel="nofollow"]', text: 'Delete')
    end

    it 'has correct icon value' do
      expect(helper.link_to_delete('Delete', '/foo')).to have_css('a i.bi.bi-trash')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_delete('Delete', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'Delete')
    end

    it 'allows custom icon' do
      expect(helper.link_to_delete('Delete', '/foo', icon: 'bi bi-exclamation')).to have_css('a i.bi.bi-exclamation')
    end
  end

  context 'with #link_to_edit' do
    it 'returns default button' do
      expect(helper.link_to_edit('Edit', '/foo')).to have_css('a.btn.btn-info.btn-action', text: 'Edit')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_edit('Edit', '/foo')).to have_css('a[role="button"]', text: 'Edit')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_edit('Edit', '/foo')).to have_css('a[title="Edit"]', text: 'Edit')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_edit('Edit', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'Edit')
    end

    it 'has correct icon value' do
      expect(helper.link_to_edit('Edit', '/foo')).to have_css('a i.bi.bi-pencil')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_edit('Edit', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'Edit')
    end

    it 'allows custom icon' do
      expect(helper.link_to_edit('Edit', '/foo', icon: 'bi bi-exclamation')).to have_css('a i.bi.bi-exclamation')
    end
  end

  context 'with #link_to_index' do
    it 'returns default button' do
      expect(helper.link_to_index('Index', '/foo')).to have_css('a.btn.btn-secondary.btn-action', text: 'Index')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_index('Index', '/foo')).to have_css('a[role="button"]', text: 'Index')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_index('Index', '/foo')).to have_css('a[title="Index"]', text: 'Index')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_index('Index', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'Index')
    end

    it 'has correct icon value' do
      expect(helper.link_to_index('Index', '/foo')).to have_css('a i.bi.bi-collection')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_index('Index', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'Index')
    end

    it 'allows custom icon' do
      expect(helper.link_to_index('Index', '/foo', icon: 'bi bi-exclamation')).to have_css('a i.bi.bi-exclamation')
    end
  end

  context 'with #link_to_new' do
    it 'returns default button' do
      expect(helper.link_to_new('New', '/foo')).to have_css('a.btn.btn-success.btn-action', text: 'New')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_new('New', '/foo')).to have_css('a[role="button"]', text: 'New')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_new('New', '/foo')).to have_css('a[title="New"]', text: 'New')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_new('New', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'New')
    end

    it 'has correct icon value' do
      expect(helper.link_to_new('New', '/foo')).to have_css('a i.bi.bi-file-earmark-plus')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_new('New', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'New')
    end

    it 'allows custom icon' do
      expect(helper.link_to_new('New', '/foo', icon: 'bi bi-exclamation')).to have_css('a i.bi.bi-exclamation')
    end
  end

  context 'with #link_to_show' do
    it 'returns default button' do
      expect(helper.link_to_show('Show', '/foo')).to have_css('a.btn.btn-primary.btn-action', text: 'Show')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_show('Show', '/foo')).to have_css('a[role="button"]', text: 'Show')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_show('Show', '/foo')).to have_css('a[title="Show"]', text: 'Show')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_show('Show', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'Show')
    end

    it 'has correct icon value' do
      expect(helper.link_to_show('Show', '/foo')).to have_css('a i.bi.bi-eye')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_show('Show', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'Show')
    end

    it 'allows custom icon' do
      expect(helper.link_to_show('Show', '/foo', icon: 'bi bi-exclamation')).to have_css('a i.bi.bi-exclamation')
    end
  end

  context 'with #link_to_custom' do
    it 'returns default button' do
      expect(helper.link_to_custom('Custom', '/foo')).to have_css('a.btn.btn-secondary.btn-action', text: 'Custom')
    end

    it 'has correct `role` value' do
      expect(helper.link_to_custom('Custom', '/foo')).to have_css('a[role="button"]', text: 'Custom')
    end

    it 'has correct `title` value' do
      expect(helper.link_to_custom('Custom', '/foo')).to have_css('a[title="Custom"]', text: 'Custom')
    end

    it 'has correct `data-bs-toggle` value' do
      expect(helper.link_to_custom('Custom', '/foo')).to have_css('a[data-bs-toggle="tooltip"]', text: 'Custom')
    end

    it 'has correct icon value' do
      expect(helper.link_to_custom('Custom', '/foo')).to have_css('a i.bi.bi-exclamation')
    end

    it 'allows custom `class`' do
      expect(helper.link_to_custom('Custom', '/foo', class: 'btn btn-foo')).to have_css('a.btn.btn-foo', text: 'Custom')
    end

    it 'allows custom icon' do
      expect(helper.link_to_custom('Custom', '/foo', icon: 'bi bi-home')).to have_css('a i.bi.bi-home')
    end
  end
end
