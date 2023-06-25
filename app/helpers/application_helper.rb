module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.append 'flash', partial: 'shared/flash'
  end

  def render_turbo_stream_inline_flash_messages
    turbo_stream.append('flash', partial: 'shared/flash')
  end
end
