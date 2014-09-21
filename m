Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56666 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaIUKHF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Sep 2014 06:07:05 -0400
Received: by mail-wi0-f181.google.com with SMTP id z2so1472080wiv.2
        for <linux-wpan@vger.kernel.org>; Sun, 21 Sep 2014 03:07:03 -0700 (PDT)
Date: Sun, 21 Sep 2014 12:06:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140921100656.GA30821@omega>
References: <20140918160458.GB9262@omega>
 <541B0E3B.9000201@xsilon.com>
 <20140918170724.GA11661@omega>
 <20140918175405.GC11661@omega>
 <20140918175617.GA12638@omega>
 <541B24CA.1090404@xsilon.com>
 <20140918185348.GA12931@omega>
 <20140918203445.GA14182@omega>
 <20140919101108.GC19085@omega>
 <541D26C5.5010404@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541D26C5.5010404@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

On Sat, Sep 20, 2014 at 08:03:33AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> I noticed the 802.15.4 spec mentions that when promiscuous mode is set it
> zeroes out the source and destination addressing mode of received packets
> which seems to suggest that the packet should not be handled by the stack
> also implying this is a monitor mode. Carry on with your design which I've
> had a chance to look through and it looks great.  I can implement whatever I
> need in a separate debug branch.
> 

this design is like mac80211 and removed all unnecessary things which we
don't need, just grab some ideas from. I feeling happy that you like that, thanks.
But note this isn't finished also names like ieee802154_hdr_foo, of
course I will not name it _foo, just for integration process. But there
are also some other issues/todos and need to find solutions.

- Alex
