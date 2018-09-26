Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f176.google.com ([209.85.160.176]:40151 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeI0Bzq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 26 Sep 2018 21:55:46 -0400
Received: by mail-qt1-f176.google.com with SMTP id e9-v6so188991qtp.7
        for <linux-wpan@vger.kernel.org>; Wed, 26 Sep 2018 12:41:15 -0700 (PDT)
Date: Wed, 26 Sep 2018 15:41:09 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: about openthread and 6lowpan
Message-ID: <20180926194109.ovjgvdeb5ktkbcec@x220t>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <3503.1536526189@localhost>
 <20180910150647.dcwoyslxrusvcj7j@x220t>
 <SG2PR04MB3158C4FE1DDE26E663803449EF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315858186E9C80FF004576DFEF130@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <20180924205657.nfj7mhodj4t3qox7@x220t>
 <SG2PR04MB3158B256663D74477E756933EF150@SG2PR04MB3158.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR04MB3158B256663D74477E756933EF150@SG2PR04MB3158.apcprd04.prod.outlook.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujay G <sujay.g@hcl.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Wed, Sep 26, 2018 at 01:28:09PM +0000, Sujay G wrote:
> Alex,
> 
> I am referring to  the presentation you gave on  Netdev 2.1 IOT Without Things: Building virtual 6LoWPAN Mesh Networks
> I am trying to connect PHY0 and PHY1  as shown in the presentation but so far Iam unable to do so.
> I could get only following steps  from the video
> echo “add 1 2” > /sys/kernel/debug/fakelb/edges
> ip netns exec wpan0 sh ~/host lowpan0 0 &

this is old api. I wanted to replace debugfs with netlink which I did.
The feature what you are looking for is now upstream in a new driver
named "mac802154_hwsim" - you need a recent kernel...

Having two nodes connected to each other fakelb is enough. The new
driver allows you to run a individual mesh network with 1000 nodes
connected RIOT/Contiki/Linux/openthread/etc.... you need just enough
memory to run it. And I think with 1000 nodes it will run terrible slow,
because each userspace stack need to filter it _in_ userspace. But it's
possible...

> 
> Can you please provide the sequence of steps you used to connect PHY0 and PHY1 ?
> 

With mac802154_hwsim you need to have wpan_hwsim which I think are still
not part of wpan-tools upstream [0]. You need to apply these patches and
then run a recent kernel.

Then load mac802154_hwsim and using the tool which is more self
explained. Sorry I don't have any example currently how to set it up...
but you should try fakelb with 3 nodes, every phy is monitor.

Then on two monitors each running openthread. One monitor runs
wireshark/tshark, Then you should able too see the traffic between the
nodes.

- Alex

[0] https://www.spinics.net/lists/linux-wpan/msg05122.html
