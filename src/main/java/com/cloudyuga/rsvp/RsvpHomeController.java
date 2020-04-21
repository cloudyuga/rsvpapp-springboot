package com.cloudyuga.rsvp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;


@Controller
public class RsvpHomeController {

    @Autowired
    private UserRepository repo;

    public HashMap<String,String> values = new HashMap<String, String>();
    @RequestMapping(value = {"/","home"})
    public ModelAndView home()
    { ModelAndView mv = new ModelAndView("profile");

        mv.addObject("LOGO",System.getenv("LOGO"));
        mv.addObject("TEXT1",System.getenv("TEXT1"));
        mv.addObject("TEXT2",System.getenv("TEXT2"));
        mv.addObject("COMPANY",System.getenv("COMPANY"));
        mv.addObject("LINK",System.getenv("LINK"));
        if (System.getenv("MONGODB_HOST")==null)mv.addObject("hostname", "127.0.0.1");
        else mv.addObject("hostname",System.getenv("MONGODB_HOST"));
        return mv;
    }

    public User adding(User user)
    {
        return repo.save(user);
    }
    public List<User> getting()
    {
        return repo.findAll();

    }

    @RequestMapping(value={"/new"})
    public ModelAndView addUser( User user)
    {
        ModelAndView mv2 = home();
        adding(user);
        int COUNT = (int)repo.count();
        mv2.addObject("count",COUNT);
        //setting in table
        getting().forEach(e -> values.put(e.getName(),e.getMail()));
        mv2.addObject("data",values);
        return mv2;
    }




}
