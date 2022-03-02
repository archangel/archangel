# frozen_string_literal: true

object @user
node(:token) { @token }
node(:exp) { @exp.strftime('%FT%T.%LZ') }
