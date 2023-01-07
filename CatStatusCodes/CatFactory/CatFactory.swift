//
//  CatFactory.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Foundation

protocol CatFactoring {
    func makeCats() -> [Cat]
}

struct CatFactory: CatFactoring {
    func makeCats() -> [Cat] {
        [
            .init(statusCode: 100, description: Localized("cat.continue")),
            .init(statusCode: 101, description: Localized("cat.switching_protocols")),
            .init(statusCode: 102, description: Localized("cat.processing")),
            .init(statusCode: 103, description: Localized("cat.early_hints")),
            .init(statusCode: 200, description: Localized("cat.ok")),
            .init(statusCode: 201, description: Localized("cat.created")),
            .init(statusCode: 202, description: Localized("cat.accepted")),
            .init(statusCode: 203, description: Localized("cat.non_authoritative_information")),
            .init(statusCode: 204, description: Localized("cat.no_content")),
            .init(statusCode: 205, description: Localized("cat.reset_content")),
            .init(statusCode: 206, description: Localized("cat.partial_content")),
            .init(statusCode: 207, description: Localized("cat.multi_staus")),
            .init(statusCode: 208, description: Localized("cat.already_reported")),
            .init(statusCode: 226, description: Localized("cat.im_used")),
            .init(statusCode: 300, description: Localized("cat.multiple_choices")),
            .init(statusCode: 301, description: Localized("cat.moved_permanently")),
            .init(statusCode: 302, description: Localized("cat.moved_temporarily")),
            .init(statusCode: 303, description: Localized("cat.see_other")),
            .init(statusCode: 304, description: Localized("cat.not_modified")),
            .init(statusCode: 305, description: Localized("cat.use_proxy")),
            .init(statusCode: 306, description: Localized("cat.switch_proxy")),
            .init(statusCode: 307, description: Localized("cat.temporary_redirect")),
            .init(statusCode: 308, description: Localized("cat.permanent_redirect")),
            .init(statusCode: 400, description: Localized("cat.bad_request")),
            .init(statusCode: 401, description: Localized("cat.unauthorized")),
            .init(statusCode: 402, description: Localized("cat.payment_required")),
            .init(statusCode: 403, description: Localized("cat.forbidden")),
            .init(statusCode: 404, description: Localized("cat.not_found")),
            .init(statusCode: 405, description: Localized("cat.method_not_allowed")),
            .init(statusCode: 406, description: Localized("cat.not_acceptable")),
            .init(statusCode: 407, description: Localized("cat.proxy_authenitcation_required")),
            .init(statusCode: 408, description: Localized("cat.request_timeout")),
            .init(statusCode: 409, description: Localized("cat.conflict")),
            .init(statusCode: 410, description: Localized("cat.gone")),
            .init(statusCode: 411, description: Localized("cat.length_required")),
            .init(statusCode: 412, description: Localized("cat.precondition_falied")),
            .init(statusCode: 413, description: Localized("cat.payload_too_large")),
            .init(statusCode: 414, description: Localized("cat.uri_too_long")),
            .init(statusCode: 415, description: Localized("cat.unsupported_media_type")),
            .init(statusCode: 416, description: Localized("cat.range_not_satisfiable")),
            .init(statusCode: 417, description: Localized("cat.expectation_failed")),
            .init(statusCode: 418, description: Localized("cat.i_am_a_teapot")),
            .init(statusCode: 421, description: Localized("cat.misdirected_request")),
            .init(statusCode: 422, description: Localized("cat.unprocessable_entity")),
            .init(statusCode: 423, description: Localized("cat.locked")),
            .init(statusCode: 424, description: Localized("cat.failed_dependency")),
            .init(statusCode: 425, description: Localized("cat.too_early")),
            .init(statusCode: 426, description: Localized("cat.upgrade_required")),
            .init(statusCode: 428, description: Localized("cat.precondition_required")),
            .init(statusCode: 429, description: Localized("cat.too_many_requests")),
            .init(statusCode: 431, description: Localized("cat.request_header_fields_too_large")),
            .init(statusCode: 451, description: Localized("cat.unavailable_for_legal_reasons")),
            .init(statusCode: 500, description: Localized("cat.internal_server_error")),
            .init(statusCode: 501, description: Localized("cat.not_implemented")),
            .init(statusCode: 502, description: Localized("cat.bad_gateway")),
            .init(statusCode: 503, description: Localized("cat.service_unavailable")),
            .init(statusCode: 504, description: Localized("cat.gateway_timeout")),
            .init(statusCode: 505, description: Localized("cat.http_version_not_supported")),
            .init(statusCode: 506, description: Localized("cat.variant_also_negotiates")),
            .init(statusCode: 507, description: Localized("cat.insufficient_storage")),
            .init(statusCode: 508, description: Localized("cat.loop_detected")),
            .init(statusCode: 510, description: Localized("cat.not_extended")),
            .init(statusCode: 511, description: Localized("cat.network_authentication_required")),
        ]
    }
}
