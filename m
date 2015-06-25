Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:58115 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbFYHnr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 03:43:47 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t5P7hirX005227
	for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 09:43:44 +0200
Message-ID: <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <558BADCC.6000800@osg.samsung.com>
References: <1435213871-2450-1-git-send-email-varkab@cdac.in>
    <558BADCC.6000800@osg.samsung.com>
Date: Thu, 25 Jun 2015 09:43:40 +0200
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
From: "Phoebe Buckheister" <phoebe.buckheister@itwm.fraunhofer.de>
Reply-To: phoebe.buckheister@itwm.fraunhofer.de
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
> Hello.
>
> On 25/06/15 08:31, Varka Bhadram wrote:
>> This patch rename ieee802154_hdr member seq to sequence_number.
>
> Any good reason for this? I think seq is quite clear in this context and
> making it sequence_number has no real benefit.
>
> If others disagree I'm fine to let that one in though. No hard feelings
> about it.

Don't see the in renaming this either.

> regards
> Stefan Schmidt
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>>   include/net/ieee802154_netdev.h |    2 +-
>>   net/ieee802154/header_ops.c     |    2 +-
>>   net/mac802154/iface.c           |    2 +-
>>   net/mac802154/rx.c              |    2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/ieee802154_netdev.h
>> b/include/net/ieee802154_netdev.h
>> index 2c10a9f..9c95a74 100644
>> --- a/include/net/ieee802154_netdev.h
>> +++ b/include/net/ieee802154_netdev.h
>> @@ -88,7 +88,7 @@ struct ieee802154_hdr_fc {
>>
>>   struct ieee802154_hdr {
>>   	struct ieee802154_hdr_fc fc;
>> -	u8 seq;
>> +	u8 sequence_number;
>>   	struct ieee802154_addr source;
>>   	struct ieee802154_addr dest;
>>   	struct ieee802154_sechdr sec;
>> diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
>> index a051b69..9c3291b 100644
>> --- a/net/ieee802154/header_ops.c
>> +++ b/net/ieee802154/header_ops.c
>> @@ -90,7 +90,7 @@ ieee802154_hdr_push(struct sk_buff *skb, const struct
>> ieee802154_hdr *hdr)
>>   	int rc;
>>   	struct ieee802154_hdr_fc fc = hdr->fc;
>>
>> -	buf[pos++] = hdr->seq;
>> +	buf[pos++] = hdr->sequence_number;
>>
>>   	fc.dest_addr_mode = hdr->dest.mode;
>>
>> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
>> index 416de90..0bc0f44 100644
>> --- a/net/mac802154/iface.c
>> +++ b/net/mac802154/iface.c
>> @@ -372,7 +372,7 @@ static int mac802154_header_create(struct sk_buff
>> *skb,
>>   	hdr.fc.type = cb->type;
>>   	hdr.fc.security_enabled = cb->secen;
>>   	hdr.fc.ack_request = cb->ackreq;
>> -	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
>> +	hdr.sequence_number = atomic_inc_return(&dev->ieee802154_ptr->dsn) &
>> 0xFF;
>>
>>   	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
>>   		return -EINVAL;
>> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
>> index 5a258c1..48781a6 100644
>> --- a/net/mac802154/rx.c
>> +++ b/net/mac802154/rx.c
>> @@ -142,7 +142,7 @@ ieee802154_parse_frame_start(struct sk_buff *skb,
>> struct ieee802154_hdr *hdr)
>>   	skb->mac_len = hlen;
>>
>>   	pr_debug("fc: %04x dsn: %02x\n", le16_to_cpup((__le16 *)&hdr->fc),
>> -		 hdr->seq);
>> +		 hdr->sequence_number);
>>
>>   	cb->type = hdr->fc.type;
>>   	cb->ackreq = hdr->fc.ack_request;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


