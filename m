Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52765 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbaJFM4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 08:56:18 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH wpan-next 1/3] ieee802154: 6lowpan: fix byteorder for frag tag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141006112246.GB10024@omega>
Date: Mon, 6 Oct 2014 14:56:26 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <6A8AA715-1BEA-4929-8DC0-D0086EFE77E2@holtmann.org>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com> <A134B4A0-64A0-4E34-8F54-DBAFDC11EB22@holtmann.org> <20141006112246.GB10024@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

>>> This patch fix byteorder issues with fragment tag of generation 802.15.4
>>> 6LoWPAN fragment header.
>>> 
>>> net/ieee802154/6lowpan_rtnl.c:278:54: warning restricted __be16 degrades to integer
>>> net/ieee802154/6lowpan_rtnl.c:278:18: warning: incorrect type in assignment (different base types)
>>> net/ieee802154/6lowpan_rtnl.c:278:18:    expected restricted __be16 [usertype] frag_tag
>>> net/ieee802154/6lowpan_rtnl.c:278:18:    got unsigned short
>>> 
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> Reported-by: Marcel Holtmann <marcel@holtmann.org>
>>> ---
>>> net/ieee802154/6lowpan_rtnl.c | 9 +++++----
>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> patch has been applied to bluetooth-next tree.
>> 
> 
> mhhh, I thought I should apply these patches to wpan-next three. That's
> why it's tagged with "wpan-next" and sent to linux-wpan only.
> 
> Just for global review and such things...
> 
> Then I will send it with a bunch of patches to linux-bluetooth (I should
> change that to send pull-requests to you).

if you want to send pull requests to me that is fine as well. Right now I take patches into bluetooth-next so that they get global exposure and we get them into wireless-next on a regular basis.

I am totally fine with just applying patches one by one. That is no extra work for me. I just want to get them into the tree so that they will make it into wireless-next early on.

Regards

Marcel

