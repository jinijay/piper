package com.creactiviti.piper.taskhandler.script;

import java.util.Collections;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.core.io.ClassPathResource;

import com.creactiviti.piper.core.job.MutableJobTask;

public class BashTests {

  @Test
  public void test1 () throws Exception {
    Bash bash = new Bash();
    ClassPathResource cpr = new ClassPathResource("schema.sql");
    String output = bash.handle(new MutableJobTask(Collections.singletonMap("script", "ls -l " + cpr.getFile().getAbsolutePath())));
    Assert.assertTrue(output.contains("target/test-classes/schema.sql"));
  }
  
}
