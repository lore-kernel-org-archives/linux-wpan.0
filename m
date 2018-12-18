Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:55302 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeLRXtr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Dec 2018 18:49:47 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] 6lowpan: convert to DEFINE_SHOW_ATTRIBUTE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181215072217.26085-1-tiny.windzz@gmail.com>
Date: Wed, 19 Dec 2018 00:49:45 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <62A2F405-FC91-4A6C-85B4-A5D28E306F01@holtmann.org>
References: <20181215072217.26085-1-tiny.windzz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Yangtao,

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> net/6lowpan/debugfs.c | 13 +------------
> 1 file changed, 1 insertion(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
