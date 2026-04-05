# frozen_string_literal: true

module PlentyClient
  module Document
    include PlentyClient::Endpoint
    include PlentyClient::Request

    DOWNLOAD_DOCUMENT = '/documents/{documentId}'

    class << self
      def download(document_id, headers = {}, &)
        get(build_endpoint(DOWNLOAD_DOCUMENT, document: document_id), headers, &)
      end
    end
  end
end
