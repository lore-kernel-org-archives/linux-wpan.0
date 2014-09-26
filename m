Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:38210 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbaIZPfc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 11:35:32 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so9811383wes.36
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 08:35:30 -0700 (PDT)
Date: Fri, 26 Sep 2014 17:35:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140926153521.GA7643@omega>
References: <54258332.2010004@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54258332.2010004@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Fri, Sep 26, 2014 at 04:16:02PM +0100, Simon Vincent wrote:
> I have three nodes running linux all running in promiscuous mode with ipv6

Sorry I need to ask here, why it's in promiscuous mode? It's still
(mainline) a WPAN device? I don't know right now what changes you did
because at mainline state we don't have any support for running any
device into promiscuous mode.

> forwarding enabled. The kernel is built from wpan-next. The three nodes are
> all connected directly using 802.15.4.
> 
> Node A: fe80::203:9a00:0:a
> Node B: fe80::203:9a00:0:b
> Node C: fe80::203:9a00:0:c
> 
> If from node A I ping node B I get ICMP redirects from node C. Node C also
> forwards the packet to node B so node B receives the ping request twice.
> 

I have also 3 nodes here, maybe I can reproduce this scenario to help
there. Can you give me some setup steps for this?

> If I try a similar setup using ethernet instead of 802.15.4 I do not get
> this problem.
> 
> Has anyone else seen this?
> 

No, I am still try to get some basic features working which should work. :-)

- Alex
