Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56497 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093AbbHGHmy (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 7 Aug 2015 03:42:54 -0400
Subject: Re: [RFCv5 bluetooth-next 4/4] ieee802154: add ack request default
 handling
References: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
 <1438846116-4787-5-git-send-email-alex.aring@gmail.com>
 <55C39B4E.1070100@osg.samsung.com> <20150807064355.GA1975@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C4617A.3040300@osg.samsung.com>
Date: Fri, 7 Aug 2015 09:42:50 +0200
MIME-Version: 1.0
In-Reply-To: <20150807064355.GA1975@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 07/08/15 08:43, Alexander Aring wrote:
> On Thu, Aug 06, 2015 at 07:37:18PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 06/08/15 09:28, Alexander Aring wrote:
>>> This patch introduce a new mib entry which isn't part of 802.15.4 but
>>> useful as default behaviour to set the ack request bit or not if we
>>> don't know if the ack request bit should set. This is currently used for
>>> stacks like IEEE 802.15.4 6LoWPAN.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>   include/net/cfg802154.h     |  5 +++++
>>>   include/net/nl802154.h      |  4 ++++
>>>   net/ieee802154/6lowpan/tx.c |  2 +-
>>>   net/ieee802154/nl802154.c   | 33 +++++++++++++++++++++++++++++++++
>>>   net/ieee802154/rdev-ops.h   | 13 +++++++++++++
>>>   net/ieee802154/trace.h      | 19 +++++++++++++++++++
>>>   net/mac802154/cfg.c         | 11 +++++++++++
>>>   7 files changed, 86 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
>>> index 382f94b..21353f8 100644
>>> --- a/include/net/cfg802154.h
>>> +++ b/include/net/cfg802154.h
>>> @@ -63,6 +63,8 @@ struct cfg802154_ops {
>>>   					 s8 max_frame_retries);
>>>   	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
>>>   				struct wpan_dev *wpan_dev, bool mode);
>>> +	int	(*set_ackreq_default)(struct wpan_phy *wpan_phy,
>>> +				      struct wpan_dev *wpan_dev, bool ackreq);
>>>   };
>>>   static inline bool
>>> @@ -193,6 +195,9 @@ struct wpan_dev {
>>>   	bool lbt;
>>>   	bool promiscuous_mode;
>>> +
>>> +	/* fallback for acknowledgment bit setting */
>>> +	bool ackreq;
>>>   };
>>>   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
>>> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
>>> index b0ab530..cf2713d 100644
>>> --- a/include/net/nl802154.h
>>> +++ b/include/net/nl802154.h
>>> @@ -52,6 +52,8 @@ enum nl802154_commands {
>>>   	NL802154_CMD_SET_LBT_MODE,
>>> +	NL802154_CMD_SET_ACKREQ_DEFAULT,
>>> +
>>>   	/* add new commands above here */
>>>   	/* used to define NL802154_CMD_MAX below */
>>> @@ -104,6 +106,8 @@ enum nl802154_attrs {
>>>   	NL802154_ATTR_SUPPORTED_COMMANDS,
>>> +	NL802154_ATTR_ACKREQ_DEFAULT,
>>> +
>>>   	/* add attributes here, update the policy in nl802154.c */
>>>   	__NL802154_ATTR_AFTER_LAST,
>>> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
>>> index 2597abb..1bf4a30 100644
>>> --- a/net/ieee802154/6lowpan/tx.c
>>> +++ b/net/ieee802154/6lowpan/tx.c
>>> @@ -224,7 +224,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
>>>   	} else {
>>>   		da.mode = IEEE802154_ADDR_LONG;
>>>   		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
>>> -		cb->ackreq = wpan_dev->frame_retries >= 0;
>>> +		cb->ackreq = wpan_dev->ackreq;
>>>   	}
>>>   	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
>>> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
>>> index 68f2401..1b00a14 100644
>>> --- a/net/ieee802154/nl802154.c
>>> +++ b/net/ieee802154/nl802154.c
>>> @@ -230,6 +230,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
>>>   	[NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
>>>   	[NL802154_ATTR_SUPPORTED_COMMANDS] = { .type = NLA_NESTED },
>>> +
>>> +	[NL802154_ATTR_ACKREQ_DEFAULT] = { .type = NLA_U8 },
>>>   };
>>>   /* message building helper */
>>> @@ -458,6 +460,7 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>>>   	CMD(set_max_csma_backoffs, SET_MAX_CSMA_BACKOFFS);
>>>   	CMD(set_max_frame_retries, SET_MAX_FRAME_RETRIES);
>>>   	CMD(set_lbt_mode, SET_LBT_MODE);
>>> +	CMD(set_ackreq_default, SET_ACKREQ_DEFAULT);
>>>   	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
>>>   		CMD(set_tx_power, SET_TX_POWER);
>>> @@ -656,6 +659,10 @@ nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
>>>   	if (nla_put_u8(msg, NL802154_ATTR_LBT_MODE, wpan_dev->lbt))
>>>   		goto nla_put_failure;
>>> +	/* ackreq default behaviour */
>>> +	if (nla_put_u8(msg, NL802154_ATTR_ACKREQ_DEFAULT, wpan_dev->ackreq))
>>> +		goto nla_put_failure;
>>> +
>>>   	genlmsg_end(msg, hdr);
>>>   	return 0;
>>> @@ -1042,6 +1049,24 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
>>>   	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
>>>   }
>>> +static int
>>> +nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
>>> +{
>>> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
>>> +	struct net_device *dev = info->user_ptr[1];
>>> +	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
>>> +	bool ackreq;
>>> +
>>> +	if (netif_running(dev))
>>> +		return -EBUSY;
>> I was not able to change ackreq_default on a running wpan0 interface
>>
> yes.
>
>> root@raspberrypi:~/wpan-tools-0.4# iwpan wpan0 set ackreq_default 1
>> command failed: Device or resource busy (-16)
>>
>> Which makes it impossible to change it per frame as you stated in the cover
>> letter. I guess this should go.
>>
> yea, ehm I think everybody (including myself) is confused now.
>
> The behaviour before was only indicated by max_frame_retries "-1" or
> max_frame_retries above 0. Which means:
>
>   - NO ARET (transmit doesn't wait for ack) == (max_frame_retries = -1)
>   - ARET (transmit wait for ack, the ARET mechanism was used by using the
>           max_frame_retries >= 0 parameter, which is can only be done by
> 	 transceiver)
>
> The max_frame_retries parameter is only changed when the interface was
> down, this was meant by "it was not per frame handling", which ends in
> some awkward behaviour because you can set the ack request bit in cases
> where the user can define it (e.g. af_802154). For 6LoWPAN ackreq was
> set now by (max_frame_retries >= 0) condition.
>
> What we did now is to remove the (max_frame_retries = -1) value and let
> the max_frame_retries configureable even it's ARET or NO ARET mode.
> (Note this value is only a parameter for the ARET mode algorithm, so it
>   isn't used on NO ARET mode).
>
> All transceiver drivers should now indicate by ack request bit if it
> should going into ARET mode or NO ARET mode and this handling is per frame.
> It hasn't nothing to do with the ackreq_default entry (Maybe I should be
> more clear in the cover-letter).
>
>
> What I always thought before is that the at86rf2xx transceivers and
> going into TX_ARET_ON will indicate (ARET mode only), so it always waits
> for an ack frame after transmit. -> Since RFCv5 I know this isn't true
> you can check the this behaviour with my debugfs patches. The
> transceiver will check on ackreq bit on his own and then wait for ack or
> not.
>
> This means the at86rf2xx transceivers can be run in TX_ARET_ON also in
> TX_ON by setting ackreq bit always to false (doesn't wait for ack) and
> min_be = 0 (disable CSMA handling). What we can't turn off is the CCA
> handling (maybe you can disable it by choosing the lowest threshold for
> energy above threshold "or"), but then it's the same mechanism like TX_ON.
>
> Don't know now why we always turn into TX_ON mode by when NO ARET mode
> when the transceiver decide on his own if ack request bit is set or not.
> Maybe somebody also didn't saw that on the first sight at the datasheet
> and never looked back how TX_ARET_ON is working. (The name is also
> really confused).
>
>
> Now to your question:
>
> We can change it that we allow to this value during ifup.
> The question is here if we want a "clean" change to this value.
>
> While changing this parameter, there could be frames in netdev queues
> which are still pending. This will only affects then new frames which
> comming into this queue.
>
> The simplest way would again to do this handling when ifdown. I know I
> do this if (!netif_running(dev)) too many and maybe it also doesn't
> matter a "clean" locking to changing this parameter because we doesn't
> care then if this bit is set for 4-7 frames when we set it. If you want
> I can change it.

No, keep it as you have it right now. Changing this only while the 
device is down is ok for now. We might want to re-visit all the places 
where we have been careful at some later point but for no this is fine.

You should have a reviewied-by tag for all patches now from my side 
(kernel and wpan-tools). I'm fine with this series getting merged.

regards
Stefan Schmidt
