Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61192 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaJTRYp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 13:24:45 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7781818wiv.17
        for <linux-wpan@vger.kernel.org>; Mon, 20 Oct 2014 10:24:44 -0700 (PDT)
Date: Mon, 20 Oct 2014 19:24:38 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: multicast problems
Message-ID: <20141020172435.GA31180@omega>
References: <5444F889.5010600@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5444F889.5010600@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Mon, Oct 20, 2014 at 12:56:57PM +0100, Simon Vincent wrote:
> Has anyone had any luck using Site-Local or Realm-Local multicast over
> 14.5/6lowpan?
> 
> I find if I subscribe to a multicast group using a site-local or realm-local
> scope I can't ping the multicast group. If I try the same on a ethernet
> interface I can ping the multicast group no problems.

mhh, did you also tried it without the overwritten pkt_type value
PACKET_HOST? Just drop it in 802.15.4 6LoWPAN for testing case.

Maybe, you hit the problem at [0].

This occurs when "Type 131 - Multicast Listener Report" arrived. [1]

Don't know much about Multicast Listener Report at the moment and if this
is really necessary for your use case.

Just give it a try. It's something with multicast and I know there is
some issue right now.

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/mcast.c#L1426
[1] http://www.iana.org/assignments/icmpv6-parameters/icmpv6-parameters.xhtml#icmpv6-parameters-codes-9
