Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37915 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933472AbbKMK3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Nov 2015 05:29:37 -0500
Received: by wmec201 with SMTP id c201so24260806wme.1
        for <linux-wpan@vger.kernel.org>; Fri, 13 Nov 2015 02:29:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151112085333.GA3045@omega>
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com>
	<CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com>
	<CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
	<CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
	<20151112085333.GA3045@omega>
Date: Fri, 13 Nov 2015 11:29:36 +0100
Message-ID: <CAPpUg6P259rf9NXGpDXqNq2Qragc5Ht9ZvQCSaDGSG1vSWcbZg@mail.gmail.com>
Subject: Re: 6lowpan socket
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Christopher Friedt <chrisfriedt@gmail.com>, linux-wpan@vger.kernel.org

2015-11-12 9:53 GMT+01:00 Alexander Aring <alex.aring@gmail.com>:
> Hi Baptiste,
>
> On Thu, Nov 12, 2015 at 01:14:48AM +0100, Baptiste Clenet wrote:
>> From Christopher:
>>
>> Oh - sorry. 6LowPAN uses IPv6. So it's equivalent to setting up an IPv6 socket.
>>
>> Just remember to set up routes as appropriate and it should work fine.
>>
>> Unfortunately, I think vger bounces email from android devices, so my
>> message won't make it out on the list.
>>
>> ©
>>
>> Sent from my Android
>>
>> Yeah sure, it's equivalent, it's what I thought. I will search deeper
>
> I see you as well on the RIOT mailinglist. Do you has these issues with
> RIOT?
>

Yes I'm in both mailing list.
The problem was not with Riot but openwrt. It works now, thanks you.

> You can check it with fakelb and bsd-netcat and create/connect udp v6 socket,
> if it works with a linux<->linux connection, otherwise something is
> wrong with interoperability (which you can might debug via sniffing).
>
> I know they have recently added the rfc6282 udp nhc compression, see
> [0]. We have nhc_udp enabled by default, (receive handling should have
> a always possible strategy).
>
> Usually you can disable UDP NHC by unloading the "nhc_udp" module if you
> built it as module. But then you can also not receive anymore other udp
> nhc iphc headers.
>
> To make a fine granularity setting to the nhc strategy, we need a
> userspace tool and interface for that.
>
> - Alex
>
> [0] https://github.com/RIOT-OS/RIOT/pull/4189


Ok for nhc compression, I let the default configuration and it worked.

I'm wondering something else about IPV6, how to change the default
IPV6 that the at86rf2XX will trigger?
If we change the IPV6 of lowpan0 (with ip -6 addr del ... for
instance) and then add the new one, it doesn't affect the reg
IEEE_ADDR_0,1,2....
So I wanted to use iwpan but I can only change the short_addr if I'm not wrong.
Which way is the cleanest to edit the IPV6 address of the transceiver?
(and it will impact lowpan0) I thought about edit it in the at86rf23XX
driver.

-- 
Baptiste
