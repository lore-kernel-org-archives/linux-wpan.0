Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33508 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeBTKpl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Feb 2018 05:45:41 -0500
Received: by mail-pg0-f50.google.com with SMTP id g12so6979856pgs.0
        for <linux-wpan@vger.kernel.org>; Tue, 20 Feb 2018 02:45:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ac1d2dd1-b8f8-ffa6-abd4-7eb2b04dd0e1@osg.samsung.com>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
 <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com>
 <20180219163107.GB27116@work.Speedport_W_724V_09011603_05_013>
 <CAJuUDwu_TmCMZt7sQpQdip0J5DOe-nJT47G0V4K4kg3cffEfsw@mail.gmail.com>
 <9bd4f9bc-e0be-a5e0-87ed-5245b5cf3642@osg.samsung.com> <CAJuUDws623rbNS9pfnJERd7oQfvK8WY64rRxQ-aBDLzkqtFh=w@mail.gmail.com>
 <ac1d2dd1-b8f8-ffa6-abd4-7eb2b04dd0e1@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 20 Feb 2018 11:45:40 +0100
Message-ID: <CAJuUDwtOEg_gDRcXrD774fxL-DtHaEOtZmbyRWzjnBkC9GhGdA@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello,


On 20 February 2018 at 10:27, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
>
> On 02/20/2018 12:59 AM, Xue Liu wrote:
>> Hello
>>
>> On 19 February 2018 at 23:37, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>>> Hello.
>>>
>>>
>>> On 02/19/2018 10:40 PM, Xue Liu wrote:
>>>> Hello Stefan,
>>>>
>>>> Thanks for the second review.
>>>>
>>>> On 19 February 2018 at 17:31, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>>>>> Hello.
>>>>>
>>>>> On Mon, 2018-02-19 at 11:51, Xue Liu wrote:
>>>>>
>>>>>> +
>>>>>> +#ifdef DEBUG
>>>>>> +     print_hex_dump(KERN_INFO, "mcr20a rx: ", DUMP_PREFIX_OFFSET, 16, 1,
>>>>>> +                    lp->rx_buf, len, 0);
>>>>>> +     pr_info("mcr20a rx: lqi: %02hhx\n", lp->rx_lqi[0]);
>>>>>> +#endif
>>>>> Here, as well as in the corresponding TX hex_dump call I wonder how to better
>>>>> make use of it. Recompiling the driver to get the dump is not really nice.
>>>>> Having a way to have this enabled during runtime might be better. And across
>>>>> all drivers. Just thinking out loud here. Not saying you need to be he one
>>>>> implementing it. What do you think?
>>>>>
>>>>>
>>>> using module parameters may a solution.
>>> This would be an option but I was thinking more about towards a tracepoints like approach where we can dynamically enable or disable the
>>> hexdump or other debug functionality. Loading and unloading the module to change this is a bit cumbersome. This code might not even be a
>>> module at all but compiled in.
>>>
>>> I need to check what the kernel infra offers here and how other subsystems use it.
>>>
>> Do you mean "dynamic debug"
>> https://www.kernel.org/doc/html/v4.11/admin-guide/dynamic-debug-howto.html
>> ?
>> I saw there is all a version for print_hex_dump.
>
> Indeed, that would be a good way of doing it. Switch to print_hex_dump_debug() and pr_debug and eliminate the ifdef.
> That way it is always compiled in but off by default and can be dynamically enabled during runtime.
>
> Are you ok with changing this or would you prefer to stay with your current construct?
>
I will change the functions to print_hex_dump_debug() and pr_debug()
and post a new patch.

> regards
> Stefan Schmidt

Regards,

Xue Liu
