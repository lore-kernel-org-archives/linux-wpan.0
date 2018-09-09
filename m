Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-sg2apc01on0123.outbound.protection.outlook.com ([104.47.125.123]:59648
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeIIUPv (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 9 Sep 2018 16:15:51 -0400
From: Sujay G <sujay.g@hcl.com>
Subject: about openthread and 6lowpan 
Date: Sun, 9 Sep 2018 15:05:50 +0000
Message-ID: <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>,<SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
In-Reply-To: <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

 Hi,

I have been testing openThread on Docker. I wanted to use 6Lowpan with openthread.
I assumed openThread would interact with wpan interfaces  and added  wpan interfaces in container namespace  but it did not work.

Then I came across change for 6Lowpan.  Comparison yielded changes in 7 files  vs the latest openThread repositiry
github.com/openthread/openthread/compare/master...linux-wpan:af802154

I manually merged the files and am trying to resolve the errors.

Had few queries regarding the openThread and 6Lowpan

Why was the project (af802154) abandoned ?
Was openThread working with the above 6Lowpan changes ?
Does the current openThread stack support 6Lowpan ? any configuration needs to be enabled ?    or is it the right way to port the  af802154 to current implementation of openthread ?

-Sujay


::DISCLAIMER::
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only. E-mail transmission is not guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or may contain viruses in transmission. The e mail and its contents (with or without referred errors) shall therefore not attach any liability on the originator or HCL or its affiliates. Views or opinions, if any, presented in this email are solely those of the author and may not necessarily reflect the views or opinions of HCL or its affiliates. Any form of reproduction, dissemination, copying, disclosure, modification, distribution and / or publication of this message without the prior written consent of authorized representative of HCL is strictly prohibited. If you have received this email in error please delete it and notify the sender immediately. Before opening any email and/or attachments, please check them for
  viruses and other defects.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
