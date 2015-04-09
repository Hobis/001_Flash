/**
	@Name: StartStop Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-17
*/
package hbworks.uilogics.core
{
	public interface IStartStop
	{
		// :: 로직 리셋
		function reset():void;

		// :: 로직 일시재개
		function resume():void;

		// :: 로직 일시정지
		function pause():void;

		// :: 로직 완전정지
		function stop():void;

		// :: 로직 시작
		function start():void;
	}
}
