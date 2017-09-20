Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:35471 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdITRIg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Sep 2017 13:08:36 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: pull-request: ieee802154 2017-09-20
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170920123008.GA876@work.Speedport_W_724V_09011603_05_010>
Date: Wed, 20 Sep 2017 19:08:34 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <A8275381-2BDA-4F96-B8BD-E50F16554D23@holtmann.org>
References: <20170920123008.GA876@work.Speedport_W_724V_09011603_05_010>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> Here comes a pull request for ieee802154 changes I have queued up for
> this merge window.
> 
> Normally these have been coming through the bluetooth tree but as this
> three have been falling through the cracks so far and I have to review
> and ack all of them anyway I think it makes sense if I save the
> bluetooth people some work and handle them directly.
> 
> Its the first pull request I send to you so please let me know if I did
> something wrong or if you prefer a different format.

that is fine with me since I think the major contention points are gone these days. I think for 6lowpan patches we might still want them go through bluetooth-next so that they are synced properly.

Regards

Marcel

