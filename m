Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37913 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752767AbdARL3G (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Jan 2017 06:29:06 -0500
Subject: Re: please help me to integrate RPL in kernel
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
 <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
 <865f1a70-68e3-b947-f37d-ee856147c341@pengutronix.de>
 <86AE743A-D69C-469E-8693-95F7636BFD3F@gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <b43bedcc-3e9e-c929-df7c-5b6e8672ad5e@pengutronix.de>
Date: Wed, 18 Jan 2017 12:29:04 +0100
MIME-Version: 1.0
In-Reply-To: <86AE743A-D69C-469E-8693-95F7636BFD3F@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Jo=c3=a3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Cc: JANARDHANACHARI KELLA <eni.chari@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On 01/18/2017 11:55 AM, João Pedro Taveira wrote:
> Hi Alex,
> 
> Apologise me if I was too hard in my previous mail. It was a simply outflow about something that I kept for too long.
> 
> You’re right about the wide range of changes and/or contributions to kernel that RPL requires. I agree with you.
> 
> What really wroth me was the “no way out” situation.
> 
> My implementation of linux-rpl touch mainly in netdev (ipv6, icmpv6, NUD, extended headers, routing tables…). When I tried to contact netdev, I got no reply whatsoever. But before propose anything to netdev, I wanted to get linux-rpl to work with contiki using MRHOF and ETX. This would only work with feedback from 802.15.4.
> 

Yes, but MRHOF and ETX is a later step. Maybe bring at first your RPL
implementation mainline? You know... small steps?

btw:

I _never_ saw patches from you for a RPL implementation at netdev
mailinglist. If nobody replies send a "ping" afterwards, etc.

> So I tried to get some support from you. You were extremely active by then getting wpan moving forward, so I thought you could help me get metrics from wpan stack. Since you were too busy and (now I think I didn’t explained correctly what I needed) you couldn’t help me.
> 
> Now I know that you already faced and noticed the problem of MRHOF and ETX.
> 
> In a previous mail with subject “thesis - MLE” you wrote:
> “Anyway for 802.15.4 I need to implement some kernel parts to calculate
> ETX, which means I need some ack received/non ack received counters or
> something else which can be inserted for the ETX calculation (I need to
> look into that).”
> 
> From wpan, this was and still is the only problem I need to solve regarding to RPL and wpan subsystem. RPL works in a completely area of kernel.
> 
> I hope get some time to get back to this project and get some kind of stats/metrics system working with RPL Objective Function implementations.
> 

I changed my decision right now to ETX from L2 ack. Because it will work
on Unicast only. LQI is something which also works on multicast.

Anyway If you see such problem then "send-patches", this is how open
source works. Nobody will do anything when you talk about "I need that
and that...".

- Alex
