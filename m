Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38047 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbG3WPh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 18:15:37 -0400
Date: Fri, 31 Jul 2015 00:15:50 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: change netdev_priv
 to lowpan_dev
Message-ID: <20150730221549.GA1037@omega>
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
 <1438172674-31028-2-git-send-email-alex.aring@gmail.com>
 <55BA7CB5.7030605@osg.samsung.com>
 <55BA7D65.40202@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55BA7D65.40202@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no

On Thu, Jul 30, 2015 at 09:39:17PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 30/07/15 21:36, Stefan Schmidt wrote:
> >Hello.
> >
> >On 29/07/15 14:24, Alexander Aring wrote:
> >>The usually way to get the btle lowpan private data is to use the
> >>introduced lowpan_dev inline function. This patch will cleanup by using
> >>lowpan_dev consequently.
> >>
> >>Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >>---
> >>  net/bluetooth/6lowpan.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >>index 2fb7b30..93c6ba0 100644
> >>--- a/net/bluetooth/6lowpan.c
> >>+++ b/net/bluetooth/6lowpan.c
> >>@@ -871,7 +871,7 @@ static int setup_netdev(struct l2cap_chan *chan,
> >>struct lowpan_dev **dev)
> >>             &chan->src, chan->src_type);
> >>      set_bit(__LINK_STATE_PRESENT, &netdev->state);
> >>  -    *dev = netdev_priv(netdev);
> >>+    *dev = lowpan_dev(netdev);
> >>      (*dev)->netdev = netdev;
> >>      (*dev)->hdev = chan->conn->hcon->hdev;
> >>      INIT_LIST_HEAD(&(*dev)->peers);
> >
> >This patch does no longer apply. There have been 5 patches to the 6lowpan
> >file in bluetooth from Gleen. You need to rebase this one.
> >
> Looking at it in more detail its actually your own patch which makes the
> rebase necessary. The one fixing a possible race.
> 

yes, I know. I will send a v2 in the next 24 hours.

- Alex
