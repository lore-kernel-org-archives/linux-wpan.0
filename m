Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38917 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbaKQJSs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 04:18:48 -0500
Received: by mail-pa0-f54.google.com with SMTP id hz1so10767295pad.27
        for <linux-wpan@vger.kernel.org>; Mon, 17 Nov 2014 01:18:48 -0800 (PST)
Received: from [10.244.10.187] ([196.12.45.164])
        by mx.google.com with ESMTPSA id w5sm34557859pds.25.2014.11.17.01.18.45
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2014 01:18:46 -0800 (PST)
Message-ID: <5469BCA9.10401@gmail.com>
Date: Mon, 17 Nov 2014 14:45:21 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Power Management support for IEEE-802.15.4 drivers
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

None of IEEE-802.15.4 driver implements Power Management. But the devices like AT86RF230
and CC2520 work with different power modes.

Where (means probe()/start()/..) can we add these functionalities like resume() / suspend()
for the devices..?

-- 
Thanks and Regards,
Varka Bhadram.

