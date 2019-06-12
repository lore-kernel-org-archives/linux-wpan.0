Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f180.google.com ([209.85.166.180]:51128 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFLOKX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jun 2019 10:10:23 -0400
Received: by mail-it1-f180.google.com with SMTP id j194so11018659ite.0
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jun 2019 07:10:22 -0700 (PDT)
Date: Wed, 12 Jun 2019 10:10:16 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Simulating 6lowpan with mac802154_hwsim
Message-ID: <20190612141016.owy6csdatcugsgak@x220t>
References: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 06, 2019 at 07:49:07PM -0300, Ramon Fontes wrote:
> Hello all,
> 
> I've been developed a wireless network emulator for IoT
> (https://github.com/ramonfontes/mininet-iot) in which I'm using
> mac802154_hwsim. Mininet-IoT extends Mininet-WiFi
> (https://github.com/intrig-unicamp/mininet-wifi) by simulating WiFi
> through mac80211_hwsim. Mininet-WiFi already supports 6lowpan with
> fakelb and I moving everything to mac802154_hwsim. Since I'm using
> iwpan with mac802154_hwsim and given the expertise of this community,
> I was wondering whether there is any work in which simulate the data
> rate based on the distance/rssi with 6lowpan. If the answer is no,
> what would be the best way to do so? I was thinking of doing this with
> TC, but TC wouldn't work well with multiple hops. Should I develop a
> wmediumd-like simulator (https://github.com/bcopeland/wmediumd) for
> mac802154_hwsim?
> 

rssi as 802.15.4 LQI value can be set per hop in mac802154_hwsim netlink
api. For delays/drops/etc. where is the problem using by TC netem?

LQI value is *mostly dropped to garbage right now.

It was on my list to try out netem with mac802154_hwsim but I didn't do
it yet because I have no use case.

- Alex
