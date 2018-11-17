Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbeKQOsL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Nov 2018 09:48:11 -0500
Date: Fri, 16 Nov 2018 20:32:50 -0800 (PST)
Message-Id: <20181116.203250.116640520195643915.davem@davemloft.net>
Subject: Re: [PATCH V3 4/7] net: maclorawan: Add maclorawan module
 declaration
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181114160126.4445-5-starnight@g.ncu.edu.tw>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
        <20181114160126.4445-5-starnight@g.ncu.edu.tw>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: starnight@g.ncu.edu.tw
Cc: afaerber@suse.de, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, marcel@holtmann.org, dollar.chen@wtmec.com, ken.yu@rakwireless.com, linux-wpan@vger.kernel.org, stefan@datenfreihafen.org

From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Thu, 15 Nov 2018 00:01:25 +0800

> + * @rx1_window:		RX1 window opening time in mini-seconds
> + * @rx2_window:		RX2 window opening time in mini-seconds

What is a "mini-second"?
