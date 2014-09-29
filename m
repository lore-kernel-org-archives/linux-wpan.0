Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:38924 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbaI2Niu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 09:38:50 -0400
Received: by mail-we0-f178.google.com with SMTP id t60so13087783wes.9
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 06:38:48 -0700 (PDT)
Date: Mon, 29 Sep 2014 15:38:43 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929133841.GA15176@omega>
References: <20140927014243.GA26666@omega>
 <54293279.5090103@xsilon.com>
 <54293B6C.7040800@gmail.com>
 <54293DD4.1090907@xsilon.com>
 <5429441C.5000302@gmail.com>
 <5429466F.4080506@gmail.com>
 <54295556.3030800@xsilon.com>
 <20140929131200.GA14608@omega>
 <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54295FA9.8030506@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Simon,

On Mon, Sep 29, 2014 at 02:33:29PM +0100, Simon Vincent wrote:
> Yes. It seems to be part of the ipv6 std that you can't disable redirects.
> http://www.gossamer-threads.com/lists/nsp/ipv6/20760

I don't understand now. Is your issue that you want to disable redirects
but you can't. Or something is not working because PACKET_OTHERHOST has
a wrong handling.

Your first mail shows that you have issues with PACKET_OTHERHOST and
these packets are not dropped.

Now we talk about disabling ICMPv6 redirects. All PACKET_OTHERHOST
sk_buff's should be dropped by IPv6 layer.

- Alex
