/**
 * Copyright 2011 John Moore, Scott Gilroy
 *
 * This file is part of CollaboRhythm.
 *
 * CollaboRhythm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later
 * version.
 *
 * CollaboRhythm is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with CollaboRhythm.  If not, see
 * <http://www.gnu.org/licenses/>.
 */
package collaboRhythm.shared.apps.genetics.controller
{
//	import collaboRhythm.workstation.apps.genetics.view.GeneticsFullView;

	import collaboRhythm.shared.apps.genetics.view.GeneticsWidgetView;
	import collaboRhythm.shared.controller.apps.AppControllerConstructorParams;
	import collaboRhythm.shared.controller.apps.WorkstationAppControllerBase;

	import mx.core.UIComponent;

	public class GeneticsAppController extends WorkstationAppControllerBase
	{
		public static const DEFAULT_NAME:String = "Genetics";

		private var _widgetView:GeneticsWidgetView;
//		private var _fullView:GeneticsFullView;
		
		public override function get widgetView():UIComponent
		{
			return _widgetView;
		}
		
		public override function set widgetView(value:UIComponent):void
		{
			_widgetView = value as GeneticsWidgetView;
		}
		
//		public override function get fullView():UIComponent
//		{
//			return _fullView;
//		}
//		
//		public override function set fullView(value:UIComponent):void
//		{
//			_fullView = value as GeneticsFullView;
//		}
		
		public function GeneticsAppController(constructorParams:AppControllerConstructorParams)
		{
			super(constructorParams);
		}
		
		protected override function createWidgetView():UIComponent
		{
			return new GeneticsWidgetView();
		}
		
//		protected override function createFullView():UIComponent
//		{
//			return new GeneticsFullView();
//		}
		
		public override function initialize():void
		{
			super.initialize();
//			if (_sharedUser.genetics == null)
//			{
//				_healthRecordService.loadGenetics(_sharedUser);
//			}
//			(_widgetView as GeneticsWidgetView).model = _sharedUser.genetics;
//			_fullView.model = _sharedUser.genetics;
		}

		override public function get defaultName():String
		{
			return DEFAULT_NAME;
		}
	}
}