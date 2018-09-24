Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46737 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeIYC42 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Sep 2018 22:56:28 -0400
Received: by mail-qt1-f182.google.com with SMTP id h22-v6so3094878qtr.13
        for <linux-wpan@vger.kernel.org>; Mon, 24 Sep 2018 13:52:25 -0700 (PDT)
Date: Mon, 24 Sep 2018 16:52:19 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: about openthread and 6lowpan
Message-ID: <20180924205219.gkdlerbgevw3t4gr@x220t>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <3503.1536526189@localhost>
 <20180910150647.dcwoyslxrusvcj7j@x220t>
 <SG2PR04MB3158C4FE1DDE26E663803449EF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SG2PR04MB3158C4FE1DDE26E663803449EF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujay G <sujay.g@hcl.com>
Cc: Michael Richardson <mcr@sandelman.ca>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Thu, Sep 20, 2018 at 06:06:43AM +0000, Sujay G wrote:
> Alex,
> 
> I  was able to port your changes to latest open thread  successfully.
> I followed the procedure in http://www.spinics.net/lists/linux-wpan/msg04167.html  to bring up Open Thread  nodes but the nodes were not able to communicate with each other.

Should work like I described there...
Try to sniff via a virtual monitor is there is any communication on the
PHY level.

> Can you provide some pointers on  How to  connect the PHY's ?

Create three monitors and run openthread on two of them. One can be used
as monitor with wireshark. (I think there was an issue with TX and
checksum... which need to be fixed in wireshark, so don't trust if tx
looks broken)

> I have looked at https://github.com/RIOT-OS/RIOT/pull/5582  but not clear  on how to connect the PHY's using RIOT.
>  Can you please share procedure to establish communication between PHY using RIOT?
> 

It works the same, I recently send a new pull request for such feature.

- Alex
