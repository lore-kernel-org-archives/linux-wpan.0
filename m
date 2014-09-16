Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39409 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbaIPOFH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 10:05:07 -0400
Date: Tue, 16 Sep 2014 16:05:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916140459.GB6104@omega>
References: <20140916115357.GE4969@omega>
 <20140916120247.GA5217@omega>
 <20140916121844.GA5349@omega>
 <54182C6B.6090801@xsilon.com>
 <20140916123421.GA5576@omega>
 <54182FB8.4080103@xsilon.com>
 <20140916124832.GB5576@omega>
 <1410873619.4860.20.camel@jrissane-mobl.ger.corp.intel.com>
 <20140916133206.GA6104@omega>
 <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Jukka and Martin,

On Tue, Sep 16, 2014 at 04:52:50PM +0300, Jukka Rissanen wrote:
...
> Great, your example clarified the issue nicely :)
> 
> I would vote for option 2) but if it makes the code too ugly then 1) is
> ok too.
> 
I begin to have the feeling like there is a reason because there are
different indicators for consume_skb, kfree_skb. Error or not error,
because it's hard to implement it in some way to make a correct handling
without using a pointer of pointer. A pointer of pointer always means also
a unnecessary dereferencing (netdev people doesn't like unnecessary
dereferencing stuff, takes too much time).

That's why I vote also for option 2)... but we can also clarify this on
the netdev mailinglist and ask other networking kernel hackers.

- Alex
