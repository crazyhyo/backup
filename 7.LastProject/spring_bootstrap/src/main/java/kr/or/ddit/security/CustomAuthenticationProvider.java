package kr.or.ddit.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import com.jsp.dto.MemberVO;
import com.jsp.service.MemberService;

public class CustomAuthenticationProvider implements AuthenticationProvider{

	private MemberService memberService;
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		String loginId = (String) authentication.getPrincipal();
		String loginPwd = (String) authentication.getCredentials();
		
		MemberVO member = null;
		try {
			member = memberService.getMember(loginId);
		} catch(Exception e) {
			e.printStackTrace();
			throw new BadCredentialsException("서버 장애로 서비스가 불가합니다.");
		}

		if(member != null) {
			if(loginPwd.equals(member.getPwd())) {
				UserDetails authUser = new User(member);
				boolean invalidCheck = authUser.isAccountNonExpired()
									&& authUser.isAccountNonLocked()
									&& authUser.isCredentialsNonExpired()
									&& authUser.isEnabled();
				if(invalidCheck) {
					
					// 스프링 시큐리티내부 클래스로 인증 토큰을 생성한다.
					// authentication.getPrincipal() : id
					// authentication.getCredentials() : 패스워드
					
					UsernamePasswordAuthenticationToken result
						= new UsernamePasswordAuthenticationToken(authUser.getUsername(),
																  authUser.getPassword(),
																  authUser.getAuthorities());
					
					// 전달할 내용을 설정한 후
					result.setDetails(authUser);
					
					return result;
				}
				
				throw new BadCredentialsException("로그인을 불허합니다.");
				
			}else {
				throw new BadCredentialsException("패스워드가 일치하지 않습니다.");
			}
		}else {
			throw new BadCredentialsException("존재하지 않는 아이디입니다.");
		}

	}

	@Override
	public boolean supports(Class<?> authentication) { 	// 인증이 끝난 Authentication type은 이거야 라고 Authentication Manager에게 알려주는 역할의 method
														// Authentication Manager가 인증후에 뭘 보내줘야하는지도 여기서 정한다는데 자세한건 모름
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
