/*
 * 21/09/29 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;

public class MyServletRequestListener implements 
                    ServletRequestListener,
                    ServletRequestAttributeListener{

    @Override
    public void requestDestroyed(ServletRequestEvent arg){
        System.out.println("[MyServletRequestListener] requestDestroyed");
    }

    @Override
    public void requestInitialized(ServletRequestEvent arg){
        System.out.println("[MyServletRequestListener] requestInitialized");
    }

	@Override
	public void attributeAdded(ServletRequestAttributeEvent arg0) {
        System.out.println("[MyServletRequestListener] attributeAdded");
        System.out.println("=> " + arg0.getName());
	}

	@Override
	public void attributeRemoved(ServletRequestAttributeEvent arg0) {
        System.out.println("[MyServletRequestListener] attributeRemoved");
        System.out.println("=> " + arg0.getName());
	}

	@Override
	public void attributeReplaced(ServletRequestAttributeEvent arg0) {
        System.out.println("[MyServletRequestListener] attributeReplaced");
        System.out.println("=> " + arg0.getName());
	}
}
