Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48002 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaJPLos (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Oct 2014 07:44:48 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so3128966pdj.27
        for <linux-wpan@vger.kernel.org>; Thu, 16 Oct 2014 04:44:48 -0700 (PDT)
Received: from [10.244.10.187] ([196.12.45.164])
        by mx.google.com with ESMTPSA id f7sm7896106pdj.15.2014.10.16.04.44.45
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Oct 2014 04:44:46 -0700 (PDT)
Message-ID: <543FAF07.6090205@gmail.com>
Date: Thu, 16 Oct 2014 17:11:59 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Debug message API names for WPAN
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

I am planning to implement the debug message API's for WPAN.

I thought of using the name started with wpan_*. ex: wpan_info(),wpan_dbg()..

Is this API name is OK....?

In which header file i can add these '#define's.. ieee802154.h or mac802154.h..?

If these things are confirmed patches are on the way.

-- 
Thanks and Regards,
Varka Bhadram.

