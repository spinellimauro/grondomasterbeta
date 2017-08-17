package controller

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.builder.SpringApplicationBuilder
import org.springframework.boot.web.support.SpringBootServletInitializer
import org.springframework.context.annotation.ImportResource
import master.LigaMaster

@SpringBootApplication
class Application extends SpringBootServletInitializer {
  def static void main(String[] args) {
      SpringApplication.run(Application, args);
  }

  
  override SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
      return builder.sources(Application);
  }
}