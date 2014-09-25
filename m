Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55028 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaIYFzN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Sep 2014 01:55:13 -0400
Date: Thu, 25 Sep 2014 07:55:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140925055504.GA24765@omega>
References: <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com>
 <20140916140459.GB6104@omega>
 <54184CDB.9050200@xsilon.com>
 <20140916173806.GC6104@omega>
 <54188817.80707@xsilon.com>
 <20140916193723.GD6104@omega>
 <54189522.9090405@xsilon.com>
 <20140916200754.GE6104@omega>
 <54189B6E.5080905@xsilon.com>
 <20140916203032.GG6104@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140916203032.GG6104@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 16, 2014 at 10:30:32PM +0200, Alexander Aring wrote:
...
> 
> Maybe simple do that what Jukka said, to handle the kfree_skb inside of
> lowpan_process_data. What's wrong now with that?
> 

ping. Really bad issue, what's about the state to fix it?

- Alex
