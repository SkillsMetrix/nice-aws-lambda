package com.errorhandler;

 
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.amazonaws.util.StringUtils;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class LambdaFunction implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent>{
	private static final Gson gson= new GsonBuilder().setPrettyPrinting().create();
	


	@Override
	public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent input, Context context) {
		// TODO Auto-generated method stub
		final LambdaLogger logger= context.getLogger();
		//log the entire event
		logger.log("API Full Event  "+ input.toString());
		
		//gets the user details from POST call and saves to DB
		String body= input.getBody();
		final User user=gson.fromJson(body, User.class);
		//check if username and id are not null
		if(StringUtils.isNullOrEmpty(user.getUsername()) || user.getId()== null){
			 throw new RuntimeException("Details are not valid...!");
		}
		return null;
	}

}
