Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35331 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbbKLIxp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Nov 2015 03:53:45 -0500
Received: by wmdw130 with SMTP id w130so144527311wmd.0
        for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2015 00:53:44 -0800 (PST)
Date: Thu, 12 Nov 2015 09:53:38 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan socket
Message-ID: <20151112085333.GA3045@omega>
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com>
 <CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com>
 <CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
 <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Christopher Friedt <chrisfriedt@gmail.com>, linux-wpan@vger.kernel.org

Hi Baptiste,

On Thu, Nov 12, 2015 at 01:14:48AM +0100, Baptiste Clenet wrote:
> From Christopher:
> 
> Oh - sorry. 6LowPAN uses IPv6. So it's equivalent to setting up an IPv6 socket.
> 
> Just remember to set up routes as appropriate and it should work fine.
> 
> Unfortunately, I think vger bounces email from android devices, so my
> message won't make it out on the list.
> 
> ©
> 
> Sent from my Android
> 
> Yeah sure, it's equivalent, it's what I thought. I will search deeper

I see you as well on the RIOT mailinglist. Do you has these issues with
RIOT?

You can check it with fakelb and bsd-netcat and create/connect udp v6 socket,
if it works with a linux<->linux connection, otherwise something is
wrong with interoperability (which you can might debug via sniffing).

I know they have recently added the rfc6282 udp nhc compression, see
[0]. We have nhc_udp enabled by default, (receive handling should have
a always possible strategy).

Usually you can disable UDP NHC by unloading the "nhc_udp" module if you
built it as module. But then you can also not receive anymore other udp
nhc iphc headers.

To make a fine granularity setting to the nhc strategy, we need a
userspace tool and interface for that.

- Alex

[0] https://github.com/RIOT-OS/RIOT/pull/4189
