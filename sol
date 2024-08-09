package com.java.aws.sns;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.AmazonSNSClientBuilder;
@Configuration
public class AwsSNSConfig {
	
	public static final String SECRET_KEY="";
	public static final String ACCESS_KEY="";
	@Bean
	@Primary
	public AmazonSNSClient snsClient() {
		return (AmazonSNSClient)AmazonSNSClientBuilder.standard()
				.withRegion(Regions.US_EAST_1)
				.withCredentials(new AWSStaticCredentialsProvider
						(new BasicAWSCredentials(ACCESS_KEY,SECRET_KEY))).build();
				
	}

}



-------------

package com.java.aws.sns;

import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.amazonaws.services.sns.model.SubscribeRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.aws.autoconfigure.context.ContextRegionProviderAutoConfiguration;
import org.springframework.cloud.aws.autoconfigure.context.ContextStackAutoConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication(exclude = {ContextStackAutoConfiguration.class,ContextRegionProviderAutoConfiguration.class})
@RestController
 public class SpringbootAwsSnsExampleApplication {
	
	@Autowired
	private AmazonSNSClient snsClient;
	
	String TOPIC_ARN="arn:aws:sns:us-east-1:211125489896:user1-topic";

	@GetMapping("/addsubscribe/{email}")
	public String addSubscription(@PathVariable String email) {
		SubscribeRequest request= new SubscribeRequest(TOPIC_ARN,"email",email);
		snsClient.subscribe(request);
		return "Subsription request is pending , check your mail...!  " +email;
	}
    @GetMapping("/sendnotification")
	public String publishMessageToTopic() {
    	PublishRequest request= new PublishRequest(TOPIC_ARN, "Welcome User to the Company","Have a great Day");
    	snsClient.publish(request);
    	return "NOtification sent";
		
	}

    public static void main(String[] args) {
        SpringApplication.run(SpringbootAwsSnsExampleApplication.class, args);
    }

}

