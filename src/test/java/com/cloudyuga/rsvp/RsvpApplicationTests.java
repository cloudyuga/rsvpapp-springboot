package com.cloudyuga.rsvp;

import com.mongodb.MongoClient;
import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import org.springframework.web.servlet.ModelAndView;

import java.net.UnknownHostException;
import java.util.LinkedList;
import java.util.List;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

@SpringBootTest
class RsvpApplicationTests {
    /*    @Test
        void contextLoads() {

        }*/
    @MockBean
    RsvpMongoDbConfiguration config;

    @Autowired
    private RsvpHomeController controller;

    @MockBean
    private UserRepository repository;

    @Test
    public void getUserTest()
    {
        User u = new User();
        u.setName("test");
        u.setMail("test@yt.com");
        List<User> l = new LinkedList<User>();
        l.add(u);
        when(repository.findAll()).thenReturn(l);
        Assert.assertEquals(1,controller.getting().size());

    }
    @Test
    public void setUserTest()
    {
        User u = new User();
        u.setName("test2");
        u.setMail("test2@yt.com");
        when(repository.save(u)).thenReturn(u);
        Assert.assertEquals(u,controller.adding(u));
    }
    @Test
    public void MongoConfigTest() throws UnknownHostException {
        SimpleMongoDbFactory dbFactory = new SimpleMongoDbFactory(new MongoClient(System.getenv("MONGODB_HOST"),27017),"mongos");
        when(config.getMongoTemplate()).thenReturn(new MongoTemplate(dbFactory));
        Assert.assertNotNull(config.getMongoTemplate().getCollectionNames());

    }

    @Test
    public void ModelViewTest()
    {
        ModelAndView mv = new ModelAndView("profile");
        mv.addObject("LOGO","https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png");
        mv.addObject("TEXT1","CloudYuga");
        mv.addObject("TEXT2","GarageRSVP!");
        mv.addObject("COMPANY","CloudYugaTechnologyPvt.Ltd.");
        mv.addObject("LINK","http://www.meetup.com/cloudyuga/");
        if (System.getenv("MONGODB_HOST")==null)mv.addObject("hostname", "127.0.0.1");
        else mv.addObject("hostname",System.getenv("MONGODB_HOST"));
        Assert.assertEquals(mv.toString(),controller.home().toString());
    }



}
