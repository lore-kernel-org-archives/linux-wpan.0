Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1bon0098.outbound.protection.outlook.com ([157.56.111.98]:21791
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751779AbbLIQQM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 9 Dec 2015 11:16:12 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com> <56657FCA.9000502@analog.com>
 <20151207135312.GB20826@omega> <56669828.3060606@analog.com>
 <20151208171154.GB766@omega> <5667FA02.90307@analog.com>
 <20151209145527.GA4045@omega>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56685248.8050903@analog.com>
Date: Wed, 9 Dec 2015 17:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <20151209145527.GA4045@omega>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, marcel@holtmann.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On 12/09/2015 03:55 PM, Alexander Aring wrote:
> Hi,
>
> On Wed, Dec 09, 2015 at 10:53:06AM +0100, Michael Hennerich wrote:
>> On 12/08/2015 06:11 PM, Alexander Aring wrote:
>>> Hi,
>>>
>>> On Tue, Dec 08, 2015 at 09:43:20AM +0100, Michael Hennerich wrote:
>>>> On 12/07/2015 02:53 PM, Alexander Aring wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Dec 07, 2015 at 01:47:06PM +0100, Michael Hennerich wrote:
>>>>> ...
>>>>>>>> +static struct ieee802154_ops adf7242_ops = {
>>>>>>>> +    .owner = THIS_MODULE,
>>>>>>>> +    .xmit_sync = adf7242_xmit,
>>>>>>>> +    .ed = adf7242_ed,
>>>>>>>> +    .set_channel = adf7242_channel,
>>>>>>>> +    .set_hw_addr_filt = adf7242_set_hw_addr_filt,
>>>>>>>> +    .start = adf7242_start,
>>>>>>>> +    .stop = adf7242_stop,
>>>>>>>> +    .set_csma_params = adf7242_set_csma_params,
>>>>>>>> +    .set_frame_retries = adf7242_set_frame_retries,
>>>>>>>> +    .set_txpower = adf7242_set_txpower,
>>>>>>>> +    .set_promiscuous_mode = adf7242_set_promiscuous_mode,
>>>>>>>> +    .set_cca_ed_level = adf7242_set_cca_ed_level,
>>>>>>>
>>>>>>> Nice to see so many callbacks implemented. The only things I see missing
>>>>>>> is xmit_async, set_lbt and set_cca_mode. I would not make it a
>>>>>>> requirements to get these hooked up before merging this patch but we
>>>>>>> should consider it as todo items.
>>>>>>
>>>>>> The part only supports CCA mode Energy above threshold.
>>>>>> Not sure what this LBT mode does on the AT86RFxxx driver.
>>>>>
>>>>> This is for sub 1Ghz regulations in some country (Japan/Europe) area,
>>>>> there CSMA/CA accoridng 802.15.4 isn't allowed at sub 1-Ghz, that's why
>>>>> they introduced LBT.
>>>>>
>>>>> That reminds me to work on a regulator db, again. :-)
>>>>>
>>>>> Nevertheless it should not related to 2.4 Ghz global ISM band, so far I
>>>>> know.
>>>>>
>>>>>> The ADF7242 only supports CSMA-CA and not some other listen before talk
>>>>>> flavour. The only oher option is to turn CSMA-CA completly off.
>>>>>
>>>>> Another thing for ToDo list, add support for turning CSMA-CA handling
>>>>> complete off, many transceiver has such option.
>>>>>
>>>>> There exists ways currently to turn off CSMA handling only by choosing
>>>>> the right backoff exponents, 802.15.4 writes:
>>>>>
>>>>> Note that if macMinBE is set to zero, collision avoidance will be
>>>>> disabled during the first iteration of this algorithm.
>>>>
>>>> First iteration only? And I think that is for slotted operation.
>>>> I wouldn't overload MinBe with an option to disable CSMA-CA.
>>>> Maybe add a new command?
>>>>
>>>>
>>>
>>> "CSMA" != "CSMA-CA"
>>>
>>> The calculation is for backoff periods (aUnitBackoffPeriod) is:
>>>
>>> 2^(MINBE + 1) - 1
>>>
>>> doesn't matter if slotted/unslotted. See page 23 at [0].
>>>
>>> By disable CSMA-CA I usually assume that the CCA status will not
>>> performed. Disable CSMA -> CCA status will be performed.
>>>
>>> I agree to add an own command to disable "CSMA-CA", to disable "CSMA" we
>>> have minBe.
>>>
>>
>> Hi Alex,
>>
>> ok - I see.
>>
>
> ok.
>
> Anyway the backoff period should be one aUnitBackoffPeriod, because
>
> 2^(0 + 1) - 1 = 1;
>
> I excepted zero. :-) Maybe one aUnitBackoffPeriod doesn't matter then.
>
>>
>>>>>
>>>>> Okay then another ToDo for wpan-tools would be to make a nice printout
>>>>> that CSMA is disabled if "macMinBE is set to zero".
>>>>>
>>>>>> I'm also not sure if we need to supprot the async mode, while the sync mode
>>>>>> is working. For me the async mode looks like it tries to workaround some HW
>>>>>> access issues.
>>>>>>
>>>>>
>>>>> We came to the conclusion that "sync" callback is a workaround that
>>>>> people can use spi_sync. :-)
>>>>
>>>> Hmmm - I don't quite understand.
>>>>
>>>> The difference is that xmit_sync blocks until the packet is transmitted,
>>>> while async returns immediately.
>>>
>>> Exact, and "blocking" is not what the netdev api offers by callback
>>> ".ndo_start_xmit".
>>
>> I know.
>>
>>
>
> ok.
>
>>>
>>>> spi_sync can be only used from context that can sleep. While spi_async
>>>> runs it's own queue and provides a completion callback.
>>>>
>>>> These radios can only do one thing at the time. And in both cases there are
>>>> queues that are being stopped while the radio driver is busy doing
>>>> something.
>>>>
>>>
>>> Yes, most transceivers has only one framebuffer. Btw: AT86RFxxx has
>>> really only one for rx/tx.
>>
>> Yeah - the ADF7242 also has two buffers. But still 802.15.4 is TDD/Simplex.
>> So either RX or TX. And in fact while TX with ACKreq, the RX buffer is used
>> to store the ACK, and while RX data in the TX buffer might be overwritten by
>> the ACK that is being transmitted.
>>
>
> Is the buffer locked somehow in a "safe" mode? E.g. rx/tx irq ensure
> that you can (on rx) the buffer can't be overwritten by other frames.
> (On tx) the on tx complete irq you are sure the transmit is done?

Hi Alex,

There are automatic TX_CSMA_CA to RX and other turnaround modes.
But afaict we're better off not using them.

The way it is set-up right now is that we always return to state PHY_READY.

On TX - we force CMD_RC_PHY_RDY (to exit RX), write the packet to the TX 
buf and then set CMD_RC_CSMACA. Which then starts the CSMA_CA algo. and 
generates an interrupt when the packet was transmitted and the ACK was 
or was not received. We're then again in state PHY_READY. The threaded 
IRQ handler saves the CSMA_CA status and triggers the completion and 
xmit_sync returns and enables CMD_RC_RX.

On RX we receive an interrupt when a valid packet is received which 
passes the frame filtering. The device enters state PHY_READY once the 
ACK was sent. Therefore we always wait for state PHY_READY in the 
threaded ISR. Ideally we would get the interrupt only after the ACK was 
sent if requested. (I brought this up for a firmware feature, maybe it 
gets implemented some day).


>
> This is something which AT86RFxxx provides, well there exists _under_
> real time condition, we can do some read while receive/write buffer while
> transmit. But we don't use such feature, we use the "safe" mode.
>
>>
>>>
>>>> So the only thing is the IF down/up issue?
>>>>
>>>
>>> I am not sure, I thought about that the whole day and I need to admit: I
>>> think both ways have some races _currently_.
>>>
>>> What I am suppose is that we can easier deal which such races when we
>>> use xmit_async without having a workqueue in the middle of
>>> "ndo_start_xmit" and "driver xmit" callback.
>>
>>
>> I don't see the difference with using spi_async here.
>
> The difference was said already: "the .ndo_start_xmit callback tells you:
> transmit the skb buffer _now_" (or maybe, so fast you can).
>
> Not knowning what we side effects we will get when we doing it
> delayed with a workqueue and loosing context of ".ndo_start_xmit". I
> currently have no overlook (and I think only few people has it) but I
> suppose the complete queue discipline also depends on that mechanism.
>
>> Instead of your own workqueue. You defer the work to the SPI master queue
>> (kthread)...
>> In both cases all messages are sequential. And I don't see any timing
>> benefit. It actually makes things more complex.
>
> There exists a little timing benefits, but when we talking about
> 802.15.4 then this may not important. The netdev queue for transmit is
> longer blocked by stop and wake.
>
> Also "async" is always faster than "sync", the synced spi framework is
> mostly build on-top of async framework with wait_for_completion.
>
>> Think about the case during xmit where you have to check status -> write
>> some registers -> check some other status -> write some more regsiters/data
>> -> ...
>>
>
> That's also what you need to do when you will call spi_async inside your
> spi irq handler. (Except you use a threaded irq handler).
>
>> For this to work you have to chain multiple async messages.
>
> yes. My intention is to have on hotpath -> irq context, use spi_async,
> for the rest of callbacks "might_sleep" is possible and you can use
> synced functionality.
>
>> And rely on the goodwill of the SPI master kthread to pump them out.
>>
>
> My issue is not that "the background will do the same", it's about to
> start transmit.
>
>>>
>>> Furthermore, with MLME-ops we need to send frames out which are triggered
>>> by a workqueue as well, mac80211 MLME-ops do the same.
>>>
>>> But there exist a difference by starting a xmit workqueue from "ndo_start_xmit"
>>> or "netlink command".
>>>
>>>
>>> ----
>>>
>>> Btw: while thinking the whole day I detected a "deadlock" (maybe
>>> somebody can confirm it).
>>>
>>> At [1], we have ndo_stop callback which is called under RTNL lock. This
>>> will call ieee802154_stop_device, which also flushed the xmit workqueue
>>> (That means it will wait until the workqueue is complete scheduled).
>>> Now the "worker" callback of the xmit workqueue also hold the RTNL lock,
>>> see [2]. If this is called when "stop callback" [1] is waiting for the
>>> workqueue it will wait forever, because the xmit workqueue will wait on
>>> RTNL lock.
>>
>>
>> That looks racy.
>> In the xmit_async path there is no such lock.
>> I don't know why sync versus async would need it.
>
> The ".ndo_start_xmit" says here "transmit the socket buffer now" like
> what I said above. Others netdev operation (Okay, start/stop can't
> happend here but others which are not protected by "flush_workqueue",
> means if interface still up can be handled.) can be occured between
> ".ndo_start_xmit" and schedule the workqueue.
>
>> - remove it altogether with the netif_running check.
>>
>
> ok.
>
>
> Anyway, I am willing to ack the driver with xmit_sync callback. I/Somebody
> can try to do some work on it. Then you can test sync vs async on your own
> and decide if you see an improvement.
>
> - Alex
>

Great. I looked a bit around and all wired or wireless SPI network 
drivers I’ve found all use workqueue and spi_sync in xmit.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
