Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52501 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbaHSQ1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 12:27:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so10300000pab.19
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 09:27:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140819152319.GA1116@omega>
References: <CAJ018wBU9OXQfrVr3x+EoeT0V8CM+s80xcCUvM4Urj-zdtHcsA@mail.gmail.com>
	<20140819152319.GA1116@omega>
Date: Tue, 19 Aug 2014 17:27:43 +0100
Message-ID: <CAJ018wCNUhoJQvM+bYFGqEui1KLZjHe_X3ieYr_+hVcJXQkffA@mail.gmail.com>
Subject: Re: mac802154: TX results and ACK processing
From: =?UTF-8?Q?Jo=C3=A3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Aug 19, 2014 at 4:23 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> On Tue, Aug 19, 2014 at 02:33:29PM +0100, João Pedro Taveira wrote:
>> Hi to all,
>>
>> I'm working on a RPL implementation to linux. It works with
>
> ok.
>
>> rpl_of_of0, but to get rpl_of_mhrof working, it requires ETX
>> calculations. In order to get ETX working on linux, it would be
>> required to get mac802154 Tx results. Are you planning on get track of
>> radios autoacks and/or transceivers Tx results?
>>
>
> Mh. The at86rf2xx have something to get some tx results. See [0] page
> 66, do you mean something like this?
>
> At at86rf2xx this can be read at point [1], currently we don't have any
> mac layer functionality to make this available for any other layer.
>
>> RPL must not know anything about 6lowpan, but since it will use link
>> metrics, the RPL mechanisms should be able to get neighbors links
>> stats.
>>
>
> I thought RPL needs the LQI value. For the LQI value I (we) thought about
> to handle the LQI value like the wireless signal strength.
RPL doesn't need LQI.It depends on RPL configurations and parameters,
which metrics it will use. One could setup RPL to use metrics based on
ETX, LQI, battery voltage, mains, temperature, ... sky is the limit.
>
> If you have a wireless card, simple type:
>
> "iw dev $WLAN_DEV scan dump" (maybe you need to run a scan first). You will
> see all access points and their signal strength etc.
>
> We should have something similar for all neighbor nodes and LQI values,
> tx failures and similar information.
>
>> What's your opinion?
>>
>
> I think we should get a working mac layer with a working 6LoWPAN layer
> at first, then we can do effort to implement RPL or RFC6775.
RPL works on IPv6 layer, it doesn't depend on 6lowpan. I already
started to implement several RFCs but not MHROF. Right now, I can
connect linux and contiki sensors using rpl_of_of0, but this is the
basic. To get mhrof working with default configurations as defined on
RFCs, ETX should be available. My problem is that RPL works on IPv6
layer, but ETX it's only available on link layer. Some abstraction
should be available to allow implementation of RPL metrics and RPL
Objective functions to make use of any metrics on existing link
protocols.

Joao Taveira
>
> There are currently unsolved issues and if we implement upper layers
> these issues are not easy to solve afterwards.
>
> First we should have something to offer these information in userspace.
> (Like the "iw dev $WLAN_DEV scan dump"), but you don't need these information
> in userspace. If we have this functionality, we can think about to get these
> information in RPL layer (which is kernelspace).
>
>
> btw. we are far away to offer these information in userspace.
>
> - Alex
>
> [0] http://www.atmel.com/images/doc8111.pdf
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ieee802154/at86rf230.c?id=refs/tags/v3.17-rc1#n735
