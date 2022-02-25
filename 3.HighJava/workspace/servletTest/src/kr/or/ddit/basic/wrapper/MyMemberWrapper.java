/*
 * 21/10/05 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic.wrapper;

public class MyMemberWrapper extends MemberWrapper{

    private boolean isSpy; // 첩자 여부
    private String name = "steve";
    private String company = "NASA";

    public String getName() {
        if(!isSpy){
            return super.getName();
        }else{
            return name;
        }
	}

	public String getCompany() {
        if(!isSpy){
            return super.getCompany();
        }else{
            return company;
        }
	}

	public MyMemberWrapper(IMember member){
        super(member);
    }

    public MyMemberWrapper(IMember member, boolean isSpy){
        super(member);
        this.isSpy = isSpy;
    }


}
