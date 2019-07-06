Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:48167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGFKwU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jul 2019 06:52:20 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] 6lowpan: no need to check return value of debugfs_create
 functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190614071423.GA18533@kroah.com>
Date: Sat, 6 Jul 2019 12:52:18 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <1D496433-35A6-478A-8B9D-FEEE557A2CA9@holtmann.org>
References: <20190614071423.GA18533@kroah.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hi Greg,

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Because we don't care if debugfs works or not, this trickles back a bit
> so we can clean things up by making some functions return void instead
> of an error value that is never going to fail.
> 
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-wpan@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> net/6lowpan/6lowpan_i.h | 16 ++-----
> net/6lowpan/core.c      |  8 +---
> net/6lowpan/debugfs.c   | 97 +++++++++++------------------------------
> 3 files changed, 32 insertions(+), 89 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
