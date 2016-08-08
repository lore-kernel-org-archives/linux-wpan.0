Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36430 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002AbcHHMKR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Aug 2016 08:10:17 -0400
Subject: Re: [RFCv2 bluetooth-next 00/19] bluetooth: rework 6lowpan
 implementation
References: <20160807143056.3116-1-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <628fdbf2-7600-b176-f896-08f26318048d@pengutronix.de>
Date: Mon, 8 Aug 2016 14:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

Hi,

On 08/07/2016 04:30 PM, Alexander Aring wrote:
> Hi,
> 
> This patch series is my second RFC for making btle 6lowpan into the right
> direction.
> 
> I added hopefully all suggestions which I got from RFCv1. The interface address
> will be assigned when the first l2cap chan connection gets in. This device
> address will be get by "hci_copy_identity_address" bluetooth API function and
> I hope this is the right function to get the "RPA device address".
> 
> Checkout commit message of Patch 19/19 to see how I used it.
> 
> Bad news are, I will start my master thesis shortly so I am not able to work
> on this patch series anymore.
> 

and I got the following warnings from bots/persons, I just send it here
again for the next person who like to work on that or I forget it again
the next time when I can work on this:

"ERROR: "baswap" [net/6lowpan/6lowpan.ko] undefined!"

This is because baswap is some compiled function in bluetooth module and
6lowpan doesn;t depend on that.

Another issue:

net/bluetooth/6lowpan.c:892:0-23: WARNING: lowpan_enabled_fops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

 Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
  for debugfs files.

which seems to be also affected in net/6lowpan/debugfs.c and
net/bluetooth/hci_debugfs.c

- Alex
