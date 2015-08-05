Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56093 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbbHEIqI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 5 Aug 2015 04:46:08 -0400
Subject: Re: [RFCv3 bluetooth-next 4/6] mac802154: change max_frame_retries
 behaviour
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-5-git-send-email-alex.aring@gmail.com>
 <55C0EB0E.2010005@osg.samsung.com> <20150804180009.GB22216@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C1CD4C.1070403@osg.samsung.com>
Date: Wed, 5 Aug 2015 10:46:04 +0200
MIME-Version: 1.0
In-Reply-To: <20150804180009.GB22216@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 04/08/15 20:00, Alexander Aring wrote:
> On Tue, Aug 04, 2015 at 06:40:46PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 30/07/15 10:55, Alexander Aring wrote:
>>> This patch changes the default min value of max_frame_retries to 0 and
>>> changes the max_frame_retries default value to 3 which is also 802.15.4
>>> default.
>> You mean min_frame_retries to 0 here?
> No, you mixed "frame_retries" ranges with "frame_retries" value.

So one is meant as a range, got it.

>>
>>> We don't use max_frame_retries "-1" as indicator for no-aret mode
>>> anymore, instead we checking on the ack request bit inside the 802.15.4
>>> frame control field.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>   net/mac802154/iface.c | 3 +--
>>>   net/mac802154/main.c  | 9 +++------
>>>   2 files changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
>>> index 416de90..8837c5a 100644
>>> --- a/net/mac802154/iface.c
>>> +++ b/net/mac802154/iface.c
>>> @@ -483,8 +483,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
>>>   	wpan_dev->min_be = 3;
>>>   	wpan_dev->max_be = 5;
>>>   	wpan_dev->csma_retries = 4;
>>> -	/* for compatibility, actual default is 3 */
>>> -	wpan_dev->frame_retries = -1;
>>> +	wpan_dev->frame_retries = 3;
> Here is meant the frame_retries value, 802.15.4-2011 describe this value
> as 3 for default.
>
>>>   	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
>>>   	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
>>> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
>>> index 91f1208..6e1764b 100644
>>> --- a/net/mac802154/main.c
>>> +++ b/net/mac802154/main.c
>>> @@ -109,7 +109,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>>>   	phy->supported.max_minbe = 8;
>>>   	phy->supported.min_maxbe = 3;
>>>   	phy->supported.max_maxbe = 8;
>>> -	phy->supported.min_frame_retries = -1;
>>> +	phy->supported.min_frame_retries = 0;
>>>   	phy->supported.max_frame_retries = 7;
>> Maybe also set it to 3 here if we want to have this as default and letting
>> it to userspace to set it to another value if needed?
>>
> Here is the frame_retries range by 802.15.4 which is "0..7". So now
> there comes more internal mechanism, this range is set ONLY when you the
> driver supports IEEE802154_HW_FRAME_RETRIES. If a transceiver supports
> IEEE802154_HW_FRAME_RETRIES but not the default of range "0..7" then the
> driver can overwrite this range.

Allowed range, fine.

>>>   	phy->supported.max_csma_backoffs = 5;
>>>   	phy->supported.lbt = NL802154_SUPPORTED_BOOL_FALSE;
>>> @@ -175,11 +175,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>>>   	}
>>>   	if (!(hw->flags & IEEE802154_HW_FRAME_RETRIES)) {
>>> -		/* TODO should be 3, but our default value is -1 which means
>>> -		 * no ARET handling.
>>> -		 */
>>> -		local->phy->supported.min_frame_retries = -1;
>>> -		local->phy->supported.max_frame_retries = -1;
>>> +		local->phy->supported.min_frame_retries = 3;
>>> +		local->phy->supported.max_frame_retries = 3;
>> This confuses me. During alloc_hw we set min to 0 which makes sense for me
>> but afterwards we set both, min and max, to 3? Should it not only be max to
>> three here? Am I missing something?
>>
> Here is also meant the range. But in this case the transceiver doesn't
> support IEEE802154_HW_FRAME_RETRIES. Then the stack assumes the 802.15.4
> default value and the range is "3..3".

Hmm, would it not make sense to assume that a transceiver which does not 
support IEEE802154_HW_FRAME_RETRIES does not support ARET at all?

For me it sounds more as if we would want to set the range to 0..0 here 
because the transceiver does not support IEEE802154_HW_FRAME_RETRIES 
andthus no ARET.

regards
Stefan Schmidt
