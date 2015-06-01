Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34882 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFAImU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 04:42:20 -0400
Received: by pdbnf5 with SMTP id nf5so41544166pdb.2
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 01:42:20 -0700 (PDT)
Message-ID: <556C1AD3.6030705@gmail.com>
Date: Mon, 01 Jun 2015 14:11:55 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: trace: fix name for extended
 address
References: <1433133238-16056-1-git-send-email-varkab@cdac.in> <1433133238-16056-3-git-send-email-varkab@cdac.in> <556C0BCD.5010408@osg.samsung.com> <20150601081519.GB734@omega>
In-Reply-To: <20150601081519.GB734@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

On 06/01/2015 01:45 PM, Alexander Aring wrote:

> On Mon, Jun 01, 2015 at 09:37:49AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 01/06/15 06:33, Varka Bhadram wrote:
>>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>>> ---
>>>   net/ieee802154/trace.h |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
>>> index b4295fd..9b5eefc 100644
>>> --- a/net/ieee802154/trace.h
>>> +++ b/net/ieee802154/trace.h
>>> @@ -56,7 +56,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
>>>   		__entry->type = type;
>>>   		__entry->extended_addr = extended_addr;
>>>   	),
>>> -	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, ea %llx",
>>> +	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, extended addr: %llx",
>>>   		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
>>>   		  __le64_to_cpu(__entry->extended_addr))
>>>   );
>> Please merge this with the third patch. Its really the same line and fixes
>> the output and format specifier. I don't see a need to have two patches for
>> this.
>>
> I would say fixup all patches into one and put it into the mac802154
> trace functionality at first.

Do you mean that a single patch for all these fixes.?

> What I told in my other mail was that we should use the same naming
> convention in cfg802154 and mac802154 trace for the same meaning of
> parameter. Varka fixed that for the attributes which I shown as _an_
> _example_ only, that's fine.
>
> But when I look again into this stuff then I see for example "short
> address setting". The parameter in cfg802154 trace is named as "sa" and
> in mac802154 shown as "short addr", we should keep the same name for
> that (maybe ortiented by driver ops parameter naming).

Got it.

Thanks,

-- 
Varka Bhadram

