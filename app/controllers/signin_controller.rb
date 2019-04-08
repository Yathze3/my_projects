class SignupController < ApplicationController
    before_action :authorize_access_request!, only: [:destroy]

    def create
        user = USer.find_by(email: params[:email])
        
        if user.authenticate(params[:password])
            payload = { user_id: user.id})
            session = JWTSession::Session.new(payload: payload, refresh_by_access_allowed: true)
            response.set_cookie{JWTSessions.access_cookie,
                                    value: tokens[:access],
                                    htpponly: true,
                                    secure:Rails.env.production?}
                        render json: { crsf: tokens[:csrf]}
        else
            not_found
        end
    end

    def destroy
        session = JWTSessions::Session.new(payload: payload)
        session.flush_by_by_access_payload
        render json: :ok
    end

    private 

    def not_found
        render json: { error: "Cannot find email/password combination"}, status: not_found 
    end

end