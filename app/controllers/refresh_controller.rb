class RefreshController < ApllicationController
    before_action :authorize_refresh_by_access_request!

        def create
        session = JWTSession::Session.new(payload: claimless_payload, refresh_by_Access_allowed: true)
        token = session.refresh_by_access_allowed do
            raise JWTSession::Errors::Unauthorized, "Somethings not right here!"     
        end

        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            htpponly: true,
                            secure: Rails.env.production?)
        render json: { csrf: tokens[:csrf] }
    end
end