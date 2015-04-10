Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36073 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbDJECH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Apr 2015 00:02:07 -0400
Received: by pdea3 with SMTP id a3so9345286pde.3
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 21:02:07 -0700 (PDT)
Message-ID: <55274B1A.2050900@gmail.com>
Date: Fri, 10 Apr 2015 09:31:30 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next 0/4] ieee802154: add support for phy capabilities
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com> <55261CEA.9080503@gmail.com> <20150409092818.GC1261@omega> <55264853.7060404@gmail.com> <20150409113658.GF1261@omega> <20150409123334.GI1261@omega>
In-Reply-To: <20150409123334.GI1261@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

On 04/09/2015 06:03 PM, Alexander Aring wrote:
> On Thu, Apr 09, 2015 at 01:36:58PM +0200, Alexander Aring wrote:
>> On Thu, Apr 09, 2015 at 03:07:23PM +0530, Varka Bhadram wrote:
>>> On 04/09/2015 02:58 PM, Alexander Aring wrote:
>>>> On Thu, Apr 09, 2015 at 12:02:10PM +0530, Varka Bhadram wrote:
>>>>> On 04/08/2015 04:48 PM, Alexander Aring wrote:
>>>>>> Hi,
>>>>>>
>>>>>> this patches introduce a mechanism to get phy capabilities. We simple add
>>>>>> some additional pib values like "channels_supported" information. These
>>>>>> information also includes mib values which are phy dependent like frame_retries
>>>>>> or csma_backoffs, this is necessary because the phy doing a little bit mac
>>>>>> stuff. We simple extend the pib according these phy dependent mac values.
>>>>>>
>>>>>> These capabilities are by default full 802.15.4 complaint, if some transceiver
>>>>>> supports less functionality only then these values need to be overwritten inside
>>>>>> the driver-layer.
>>>>>>
>>>>>> Fruthermore we also add functionality to dump these values via
>>>>>> NL802154_CMD_GET_WPAN_PHY.
>>>>>>
>>>>>> - Alex
>>>>>>
>>>>>> Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
>>>>>> Cc: Varka Bhadram <varkabhadram@gmail.com>
>>>>>>
>>>>>> Alexander Aring (4):
>>>>>>   ieee802154: introduce wpan_phy_supported struct
>>>>>>   ieee802154: move channels supported out of softmac
>>>>>>   ieee802154: add several phy supported handling
>>>>>>   at86rf230: set cca_modes supported flags
>>>>>>
>>>>>>  drivers/net/ieee802154/at86rf230.c | 14 ++++++++++----
>>>>>>  drivers/net/ieee802154/cc2520.c    |  2 +-
>>>>>>  drivers/net/ieee802154/fakelb.c    | 30 +++++++++++++++---------------
>>>>>>  drivers/net/ieee802154/mrf24j40.c  |  2 +-
>>>>>>  include/net/cfg802154.h            | 11 ++++++++++-
>>>>>>  net/ieee802154/nl-phy.c            |  4 ++--
>>>>>>  net/ieee802154/nl802154.c          | 29 ++++++++++++++++++++++-------
>>>>>>  net/mac802154/cfg.c                |  4 ----
>>>>>>  net/mac802154/main.c               | 10 ++++++++++
>>>>>>  9 files changed, 71 insertions(+), 35 deletions(-)
>>>>>>
>>>>> And also we need to look into expose available power level (supported by transeiver)
>>>>> to the user space by iwpan. Then user can configure the particular power level. 
>>>>>
>>>>> If not user don't know the power levels that the transceiver support.
>>>>>
>>>> yep... I will try to add it to the next series, also for ed_level. For
>>>> 700/800/900 Mhz at86rf212 it depends on which band the transceiver operates
>>>> and the available tx_power settings.
>>>>
>>>> When I try to implement it, then I need to know the country/band laws
>>>> what's the min and max tx_power db values? Does something like this
>>>> exists? Is s8 as datatype really enough to support all available
>>>> tx_power settings? -> (not because I also saw some floating point tx_power
>>>> settings, but then we simple doesn't provide them). I will try to
>>>> introduce something which supports the at86rf2xx transceiver values. We
>>>> can still change the interface again later if it doesn't fit, but then
>>>> everybody will hate us. :-)
>>>>
>>>> - Alex
>>> I think its not going to work out. But i am worrying about how the driver user
>>> will know the power levels available..?
>> You mean to know the power levels in userspace? We will introduce
>> tx_power in wpan_phy_supported of course, then we will add support for
>> dumping these values on a wpan_phy dump.
>>> How mac80211 is managing this issue..?
>> s/mac80211/wireless/
>>
>> yes, I also looked in wireless. They used a U32 type and making some
>> conversion to a floating point values by doing "value/100", do they have
>> some Y.XX value. They call the not converted value MBM and converted
>> value DBM, not sure for what MBM 100% stands.
>>
>> This is for the tx_power value.
>>
>>
>> For requesting all supported tx_power values, I run "iw phy" on my side
>> and they have only some frequency @ dbm information. And in my case the
>> dbm value was always the same for all frequency.
>>
>> This was probaly the "max tx power" value for the frequency [1].
>>
>> What wireless has is a "automatic tx power" support, so there is some
>> heuristic around to detect the optimized tx_power setting.
>>
>> The wireless tx_power looks very complicated at the moment and we should
>> first support some existing nl802154 cmd (which was also before there)
>> for setting a fixed tx_power mode. If wireless doesn't support dumping
>> for that, means not we should also not support it.
>>
>>
>>
>> Maybe we can use some:
>>
>> u64 tx_power[IEEE802154_MAX_PAGE + 1][IEEE802154_MAX_CHANNEL + 1];
>>
>> Then start some enum:
>>
>> enum nl802154_tx_power {
>> 	NL802154_TX_POWER_20DBM		= BIT(0),
>> 	NL802154_TX_POWER_19DBM		= BIT(1),
>> 	NL802154_TX_POWER_18DBM		= BIT(2),
>> 	...
>> 	NL802154_TX_POWER_NEG_44DBM	= BIT(63),
>> };
>>
> I think a better interface would be a new driver_op. Something like
> "context based list interation while rtnl is hold", some new callback:
> int get_tx_power(s8 *dbm), then nl802154 can start some nested attribute
> and we calling get_tx_power until it returns 1 which indicate the end of
> tx_power lists and ends the nested attribute. I will try to implement
> this in this way.
>
> - Alex

I think better interface would be get_tx_power() for returning the current power setting
and tx_power_supported() to get the all the available power levels.

-- 
Varka Bhadram

