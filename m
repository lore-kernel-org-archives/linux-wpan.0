Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64129 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbaIRI5N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 04:57:13 -0400
Message-ID: <541A9E65.3090300@xsilon.com>
Date: Thu, 18 Sep 2014 09:57:09 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <5412F199.7010803@xsilon.com> <20140914234551.GA7009@omega>
In-Reply-To: <20140914234551.GA7009@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

Thanks for the links, I needed this to get wireshark working again as we now have address filtering support in HW.

The code looks good and using the net device op for detecting a rx flag change looks good to me.  A couple of thoughts.
1) Maybe you could remove the HW flag for promiscuous? just let the driver implement the set_promiscuous_mode driver ops function if the HW supports it or leave it NULL if it doesn't
2) I had to implement the ndo_change_rx_flags net device ops in wpan.c not monitor.c.  For remote wireshark captures that we do we use tcpdump -i wpan0 on the boards.  Are we doing something wrong here? Your code seems to suggest that we should bring up a separate monitor interface?

- Martin.



On 15/09/14 00:45, Alexander Aring wrote:
> Hi Martin,
>
> On Fri, Sep 12, 2014 at 02:14:01PM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> You sent me a patch not long ago to allow automatic setting of promiscous mode.  I seem to have lost this patch, could you resend as I want to look into it.
>>
> some of my old branch [0].
>
> btw.
>
> I added to the rework now the promiscous mode and decided to not enable
> this mode while setting promiscous mode flag.
>
> It's now setted by doing a ifup of a monitor interface. See [1].
>
> Maybe you will change it like this (it's better) but there are so many
> issue to think about (Disable promiscous if netif on non MONITOR
> interfaces etc...).
>
> And also you can't have NODE and MONITOR running because it's phy mac
> sublayer attribute.
>
> I will cc linux-wpan, hope it's okay.
>
> In next days I will draw some fancy architecture graphic about the
> rework. To understand what I really did there. (I also have no idea
> about to implement it 100% right, I do experiments and then think about
> it "how we can do that in a better way") and very important in a way
> where we could easily handle/add _new features_.
>
> If anybody has questions about this implementation I would be very happy
> to answer them. :-)
>
> - Alex
>
> [0] https://github.com/linux-wpan/linux-wpan-next/commits/alex/wip
> [1] https://github.com/linux-wpan/linux-wpan-next/blob/d5d62172f69ecf8db4dce77e790403e532687662/net/mac802154/iface.c#L42

