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
package collaboRhythm.shared.model
{

    import collaboRhythm.shared.model.healthRecord.DocumentMetadata;
    import collaboRhythm.shared.model.healthRecord.HealthRecordHelperMethods;

    import collaboRhythm.shared.model.DateUtil;
    import collaboRhythm.shared.model.services.ICurrentDateSource;
    import collaboRhythm.shared.model.services.WorkstationKernel;

    import com.adobe.utils.DateUtil;

    import j2as3.collection.HashMap;

    [Bindable]
    public class MedicationOrder extends DocumentMetadata
    {
        private var _name:CodedValue;
        private var _orderType:String;
        private var _orderedBy:String;
        private var _dateOrdered:Date;
        private var _dateExpires:Date;
        private var _indication:String;
        private var _amountOrdered:ValueAndUnit;
        private var _refills:int;
        private var _substitutionPermitted:Boolean;
        private var _instructions:String;
//        private var _medicationFill:MedicationFill;
        private var _scheduleItems:HashMap = new HashMap();

        private var _currentDateSource:ICurrentDateSource;

        public function MedicationOrder()
        {
            _currentDateSource = WorkstationKernel.instance.resolve(ICurrentDateSource) as ICurrentDateSource;
        }

        public function init(name:CodedValue, orderType:String, orderedBy:String, dateOrdered:Date, dateExpires:Date = null, indication:String = null, amountOrdered:ValueAndUnit = null, refills:int = 0, substitutionPermitted:Boolean = false, instructions:String = null, scheduleItems:HashMap = null):void
		{
			_name = name;
            _orderType = orderType;
            _orderedBy = orderedBy;
            _dateOrdered = dateOrdered;
            _dateExpires = dateExpires;
            _indication = indication;
            _amountOrdered = amountOrdered;
            _refills = refills;
            _substitutionPermitted = substitutionPermitted;
            _instructions = instructions;
//            _medicationFill = medicationFill;
            _scheduleItems = scheduleItems;
		}

		public function initFromReportXML(medicationOrderReportXml:XML):void
		{
			parseDocumentMetadata(medicationOrderReportXml.Meta.Document[0], this);
			var medicationOrderXml:XML = medicationOrderReportXml.Item.MedicationOrder[0];
            _name = HealthRecordHelperMethods.xmlToCodedValue(medicationOrderXml.name[0]);
            _orderType = medicationOrderXml.orderType;
            _orderedBy = medicationOrderXml.orderedBy;
            _dateOrdered = collaboRhythm.shared.model.DateUtil.parseW3CDTF(medicationOrderXml.dateTimeOrdered.toString());
			_dateExpires = collaboRhythm.shared.model.DateUtil.parseW3CDTF(medicationOrderXml.dateTimeExpires.toString());
            _indication = medicationOrderXml.indication;
            _amountOrdered = new ValueAndUnit(medicationOrderXml.amountOrdered.value, HealthRecordHelperMethods.xmlToCodedValue(medicationOrderXml.amountOrdered.unit[0]));
            _refills = int(medicationOrderXml.refills);
            _substitutionPermitted = HealthRecordHelperMethods.stringToBoolean(medicationOrderXml.substitutionPermitted);
            _instructions = medicationOrderXml.instructions;
            for each (var scheduleItemXml:XML in medicationOrderReportXml..relatesTo.relation.(@type == "http://indivo.org/vocab/documentrels#scheduleItem").relatedDocument)
            {
                _scheduleItems[scheduleItemXml.@id] = null;
            }
		}

        public function convertToXML():XML
		{
			var medicationOrderXml:XML = <MedicationOrder/>;
			medicationOrderXml.@xmlns = "http://indivo.org/vocab/xml/documents#";
            // TODO: Write a helper method for coded value to xml
            medicationOrderXml.name = name.text;
            medicationOrderXml.name.@type = name.type;
            medicationOrderXml.name.@value = name.value;
            medicationOrderXml.name.@abbrev = name.abbrev;
            medicationOrderXml.orderType = orderType;
            medicationOrderXml.orderedBy = orderedBy;
            medicationOrderXml.dateOrdered = com.adobe.utils.DateUtil.toW3CDTF(dateOrdered);
            if (dateExpires)
                medicationOrderXml.dateExpires = com.adobe.utils.DateUtil.toW3CDTF(dateExpires);
            if (indication)
                medicationOrderXml.indication = indication;
            if (amountOrdered)
            {
                medicationOrderXml.amountOrdered.value = amountOrdered.value;
                medicationOrderXml.amountOrdered.unit = amountOrdered.unit.text;
                medicationOrderXml.amountOrdered.unit.@type = amountOrdered.unit.type;
                medicationOrderXml.amountOrdered.unit.@value = amountOrdered.unit.value;
                medicationOrderXml.amountOrdered.unit.@abbrev = amountOrdered.unit.abbrev;
            }
            if (refills)
                medicationOrderXml.refills = refills.toString();
            if (substitutionPermitted)
                medicationOrderXml.substitutionPermitted = HealthRecordHelperMethods.booleanToString(substitutionPermitted);
            if (instructions)
                medicationOrderXml.instructions = instructions;

			return medicationOrderXml;
		}

        public function get name():CodedValue
        {
            return _name;
        }

        public function set name(value:CodedValue):void
        {
            _name = value;
        }

        public function get orderType():String
        {
            return _orderType;
        }

        public function set orderType(value:String):void
        {
            _orderType = value;
        }

        public function get orderedBy():String
        {
            return _orderedBy;
        }

        public function set orderedBy(value:String):void
        {
            _orderedBy = value;
        }

        public function get dateOrdered():Date
        {
            return _dateOrdered;
        }

        public function set dateOrdered(value:Date):void
        {
            _dateOrdered = value;
        }

        public function get dateExpires():Date
        {
            return _dateExpires;
        }

        public function set dateExpires(value:Date):void
        {
            _dateExpires = value;
        }

        public function get indication():String
        {
            return _indication;
        }

        public function set indication(value:String):void
        {
            _indication = value;
        }

        public function get amountOrdered():ValueAndUnit
        {
            return _amountOrdered;
        }

        public function set amountOrdered(value:ValueAndUnit):void
        {
            _amountOrdered = value;
        }

        public function get refills():int
        {
            return _refills;
        }

        public function set refills(value:int):void
        {
            _refills = value;
        }

        public function get substitutionPermitted():Boolean
        {
            return _substitutionPermitted;
        }

        public function set substitutionPermitted(value:Boolean):void
        {
            _substitutionPermitted = value;
        }

        public function get instructions():String
        {
            return _instructions;
        }

        public function set instructions(value:String):void
        {
            _instructions = value;
        }

        public function get scheduleItems():HashMap
        {
            return _scheduleItems;
        }

        public function set scheduleItems(value:HashMap):void
        {
            _scheduleItems = value;
        }
    }
}
