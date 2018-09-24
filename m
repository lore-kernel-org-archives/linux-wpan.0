Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44637 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeIYDBE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Sep 2018 23:01:04 -0400
Received: by mail-qk1-f176.google.com with SMTP id d131-v6so12233701qke.11
        for <linux-wpan@vger.kernel.org>; Mon, 24 Sep 2018 13:56:59 -0700 (PDT)
Date: Mon, 24 Sep 2018 16:56:57 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: about openthread and 6lowpan
Message-ID: <20180924205657.nfj7mhodj4t3qox7@x220t>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <3503.1536526189@localhost>
 <20180910150647.dcwoyslxrusvcj7j@x220t>
 <SG2PR04MB3158C4FE1DDE26E663803449EF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315858186E9C80FF004576DFEF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SG2PR04MB315858186E9C80FF004576DFEF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujay G <sujay.g@hcl.com>
Cc: Michael Richardson <mcr@sandelman.ca>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Thu, Sep 20, 2018 at 06:57:44AM +0000, Sujay G wrote:
> Alex,
> Just wanted to mention that I am  building on ubuntu -linux.  (End  solution is to run the openthread nodes inside containers and establish communication via fakeLB) .
> Wondering if it is possible to connect the PHY devices and establish communication without RIOT? Or is  RIOT required to establish communication between PHY devices  ?
>

You don't need containers. Only if you use more than one linux IP
interfaces it's needed to avoid internal routing without hitting the mac
layer.

You don't need RIOT, you can use RIOT... you can use whatever you want
to connect to each other... question is if they will understand each
other. For openthread you need their to speak their MLE protocol
otherwise you will not get any communication.

- Alex
